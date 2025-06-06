﻿// https://github.com/TrinityCore/TrinityCore/blob/master/src/common/Debugging/WheatyExceptionReport.cpp
//==========================================
// Matt Pietrek
// MSDN Magazine, 2002
// FILE: WheatyExceptionReport.CPP
//==========================================
#include "WheatyExceptionReport.h"

// clang-format off

#include <algorithm>
#include <array>
#include <string>

#include "cbasetypes.h"
#include "logging.h"
#include "utils.h"
#include "timer.h"
#include "version.h"

#ifdef __clang__
// clang-cl doesn't have these hardcoded types available, correct ehdata_forceinclude.h that relies on it
#define _ThrowInfo ThrowInfo
#endif

#include <ehdata.h>
#include <rttidata.h>
#include <tlhelp32.h>
#include <tchar.h>
#include <psapi.h>
#include <shlwapi.h>
#include <shellapi.h>

#define CrashFolder _T("dmp")

#define EXCEPTION_ASSERTION_FAILURE 0xC0000420L

inline LPTSTR ErrorMessage(DWORD dw)
{
    LPVOID lpMsgBuf;
    DWORD formatResult = FormatMessage(
                            FORMAT_MESSAGE_ALLOCATE_BUFFER |
                            FORMAT_MESSAGE_FROM_SYSTEM,
                            nullptr,
                            dw,
                            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                            (LPTSTR) &lpMsgBuf,
                            0, nullptr);
    if (formatResult != 0)
    {
        return (LPTSTR)lpMsgBuf;
    }
    else
    {
        LPTSTR msgBuf = (LPTSTR)LocalAlloc(LPTR, 30);
        sprintf(msgBuf, "Unknown error: %u", dw);
        return msgBuf;
    }
}

std::string wstrtostr(const std::wstring &wstr)
{
    // Convert a Unicode string to an ASCII string
    std::string strTo;
    char *szTo = new char[wstr.length() + 1];
    szTo[wstr.size()] = '\0';
    WideCharToMultiByte(CP_ACP, 0, wstr.c_str(), -1, szTo, (int)wstr.length(), NULL, NULL);
    strTo = szTo;
    destroy_arr(szTo);
    return strTo;
}

std::wstring strtowstr(const std::string &str)
{
    // Convert an ASCII string to a Unicode String
    std::wstring wstrTo;
    wchar_t *wszTo = new wchar_t[str.length() + 1];
    wszTo[str.size()] = L'\0';
    MultiByteToWideChar(CP_ACP, 0, str.c_str(), -1, wszTo, (int)str.length());
    wstrTo = wszTo;
    destroy_arr(wszTo);
    return wstrTo;
}

//============================== Global Variables =============================

//
// Declare the static variables of the WheatyExceptionReport class and force their initialization before any other static in the program
//
#pragma warning(push)
#pragma warning(disable: 4073) // C4073: initializers put in library initialization area
#pragma init_seg(lib)

TCHAR WheatyExceptionReport::m_szLogFileName[MAX_PATH];
TCHAR WheatyExceptionReport::m_szDumpFileName[MAX_PATH];
LPTOP_LEVEL_EXCEPTION_FILTER WheatyExceptionReport::m_previousFilter;
_invalid_parameter_handler WheatyExceptionReport::m_previousCrtHandler;
FILE* WheatyExceptionReport::m_hReportFile;
HANDLE WheatyExceptionReport::m_hDumpFile;
HANDLE WheatyExceptionReport::m_hProcess;
SymbolPairs WheatyExceptionReport::symbols;
std::stack<SymbolDetail> WheatyExceptionReport::symbolDetails;
bool WheatyExceptionReport::alreadyCrashed;
std::mutex WheatyExceptionReport::alreadyCrashedLock;
WheatyExceptionReport::pRtlGetVersion WheatyExceptionReport::RtlGetVersion;

timer::time_point gStartUpTime = timer::now();
std::string gUptimeString;
std::string gCrashDateString;
std::string gProcessMemoryUsageString;
std::string gSystemMemoryUsageString;
std::string gCommandLineArgString;
bool gLogToConsole = true;

#pragma warning(pop)

//============================== Class Methods =============================

WheatyExceptionReport::WheatyExceptionReport() // Constructor
{
    // Install the unhandled exception filter function
    m_previousFilter = SetUnhandledExceptionFilter(WheatyUnhandledExceptionFilter);
    m_previousCrtHandler = _set_invalid_parameter_handler(WheatyCrtHandler);
    m_hProcess = GetCurrentProcess();
    alreadyCrashed = false;
    RtlGetVersion = (pRtlGetVersion)GetProcAddress(GetModuleHandle(_T("ntdll.dll")), "RtlGetVersion");

    if (!IsDebuggerPresent())
    {
        _CrtSetReportMode(_CRT_WARN, _CRTDBG_MODE_FILE);
        _CrtSetReportFile(_CRT_WARN, _CRTDBG_FILE_STDERR);
        _CrtSetReportMode(_CRT_ERROR, _CRTDBG_MODE_FILE);
        _CrtSetReportFile(_CRT_ERROR, _CRTDBG_FILE_STDERR);
        _CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_FILE);
        _CrtSetReportFile(_CRT_ASSERT, _CRTDBG_FILE_STDERR);
    }
}

//============
// Destructor
//============
WheatyExceptionReport::~WheatyExceptionReport()
{
    if (m_previousFilter)
        SetUnhandledExceptionFilter(m_previousFilter);
    if (m_previousCrtHandler)
        _set_invalid_parameter_handler(m_previousCrtHandler);
    ClearSymbols();
}

const char* GetUptimeString()
{
    auto uptimeDuration = timer::now() - gStartUpTime;
    if (uptimeDuration < 2min)
    {
        gUptimeString = fmt::format("{} seconds", std::chrono::floor<std::chrono::seconds>(uptimeDuration).count()).c_str();
    }
    else if (uptimeDuration > 2h)
    {
        gUptimeString = fmt::format("{} hours", std::chrono::floor<std::chrono::hours>(uptimeDuration).count()).c_str();
    }
    else
    {
        gUptimeString = fmt::format("{} minutes", std::chrono::floor<std::chrono::minutes>(uptimeDuration).count()).c_str();
    }

    return gUptimeString.c_str();
}

const char* GetProcessMemoryUsageString()
{
    gProcessMemoryUsageString = "Unable to retrieve memory usage";

    PROCESS_MEMORY_COUNTERS PMC;
    ULONGLONG               TotalMemoryInKilobytes;
    if (GetProcessMemoryInfo(GetCurrentProcess(), &PMC, sizeof(PMC)) && GetPhysicallyInstalledSystemMemory(&TotalMemoryInKilobytes))
    {
        gProcessMemoryUsageString = fmt::format("{}MiB / {}MiB", PMC.WorkingSetSize / 1024 / 1024, TotalMemoryInKilobytes / 1024);
    }
    return gProcessMemoryUsageString.c_str();
}

const char* GetSystemMemoryUsageString()
{
    gSystemMemoryUsageString = "Unable to retrieve memory usage";

    MEMORYSTATUSEX memInfo;
    memInfo.dwLength = sizeof(MEMORYSTATUSEX);
    if (GlobalMemoryStatusEx(&memInfo))
    {
        DWORDLONG totalPhysMem = memInfo.ullTotalPhys;
        DWORDLONG physMemUsed = memInfo.ullTotalPhys - memInfo.ullAvailPhys;

        gSystemMemoryUsageString = fmt::format("{}MiB / {}MiB", physMemUsed / 1024 / 1024, totalPhysMem / 1024 / 1024);
    }
    return gSystemMemoryUsageString.c_str();
}

const char* GetCommandLineArgsString()
{
    int     argc;
    LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);

    std::vector<std::string> strvec;
    for (int i = 0; i < argc; ++i)
    {
        strvec.emplace_back(wstrtostr(argv[i]));
    }

    gCommandLineArgString = fmt::format("{}", fmt::join(strvec, " "));

    return gCommandLineArgString.c_str();
}

//===========================================================
// Entry point where control comes on an unhandled exception
//===========================================================
LONG WINAPI WheatyExceptionReport::WheatyUnhandledExceptionFilter(
    PEXCEPTION_POINTERS pExceptionInfo)
{
    // https://www.freelists.org/post/luajit/FirstChance-Exception-in-luajit,1
    // https://love2d.org/forums/viewtopic.php?t=84336
    switch (pExceptionInfo->ExceptionRecord->ExceptionCode)
    {
       // LuaJIT throws and handles exceptions as part of its regular runtime.
       // We should ignore these. By using Sol, there is no scenario where we want a Lua error to be fatal.
       // The LuaJIT exception codes are all built by OR-ing 0xE24C4A00 with the relevant Lua error codes:
       // https://github.com/LuaJIT/LuaJIT/blob/4deb5a1588ed53c0c578a343519b5ede59f3d928/src/lj_err.c#L250-L256
       // https://github.com/LuaJIT/LuaJIT/blob/20f556e53190ab9a735b932f5d868d45ec536a70/src/lua.h#L42-L48
        case 0xE24C4A00: // LUA_OK (0)
            [[fallthrough]];
        case 0xE24C4A01: // LUA_YIELD (1)
            [[fallthrough]];
        case 0xE24C4A02: // LUA_ERRRUN (2)
            [[fallthrough]];
        case 0xE24C4A03: // LUA_ERRSYNTAX (3)
            [[fallthrough]];
        case 0xE24C4A04: // LUA_ERRMEM (4)
            [[fallthrough]];
        case 0xE24C4A05: // LUA_ERRERR (5)
            return EXCEPTION_CONTINUE_SEARCH;

        // Exceptions thrown internally (like is possible in AI state transitions) should also be ignored
        case 0xE06D7363: // Internal application exception code
            return EXCEPTION_CONTINUE_SEARCH;

        default:
            break;
    }

    std::unique_lock<std::mutex> guard(alreadyCrashedLock);

    // Handle only 1 exception in the whole process lifetime
    if (alreadyCrashed)
    {
        return EXCEPTION_EXECUTE_HANDLER;
    }

    alreadyCrashed = true;

    // A fatal event has occured, from this point on all code executed comes from our error handling.
    // We no longer need to trace where each log comes from, so change to a cleaner pattern.
    spdlog::set_pattern("%v");

    TCHAR module_folder_name[MAX_PATH];
    GetModuleFileName(nullptr, module_folder_name, MAX_PATH);
    TCHAR* pos = _tcsrchr(module_folder_name, '\\');
    if (!pos)
    {
        Log(_T("GetModuleFileName failed"));
        TerminateProcess(GetCurrentProcess(), 1);
        return EXCEPTION_EXECUTE_HANDLER; // Unreacheable code
    }

    pos[0] = '\0';
    ++pos;

    TCHAR crash_folder_path[MAX_PATH];
    sprintf_s(crash_folder_path, "%s\\%s", module_folder_name, CrashFolder);
    if (!CreateDirectory(crash_folder_path, nullptr))
    {
        if (GetLastError() != ERROR_ALREADY_EXISTS)
        {
            Log(_T("CreateDirectory failed"));
            TerminateProcess(GetCurrentProcess(), 1);
            return EXCEPTION_EXECUTE_HANDLER; // Unreacheable code
        }
    }

    SYSTEMTIME systime;
    GetLocalTime(&systime);
    sprintf(m_szDumpFileName, "%s\\%s_%u-%u_%u-%u-%u.dmp",
        crash_folder_path, pos, systime.wDay, systime.wMonth, systime.wHour, systime.wMinute, systime.wSecond);

    _stprintf(m_szLogFileName, _T("%s\\%s_%u-%u_%u-%u-%u.log"),
        crash_folder_path, pos, systime.wDay, systime.wMonth, systime.wHour, systime.wMinute, systime.wSecond);

    m_hReportFile = _tfopen(m_szLogFileName, _T("wb"));

    m_hDumpFile = CreateFile(m_szDumpFileName,
        GENERIC_WRITE,
        0,
        nullptr,
        OPEN_ALWAYS,
        FILE_FLAG_WRITE_THROUGH,
        nullptr);

    if (m_hDumpFile)
    {
        MINIDUMP_EXCEPTION_INFORMATION info;
        info.ClientPointers = FALSE;
        info.ExceptionPointers = pExceptionInfo;
        info.ThreadId = GetCurrentThreadId();

        MINIDUMP_USER_STREAM additionalStream = {};
        MINIDUMP_USER_STREAM_INFORMATION additionalStreamInfo = {};

        if (pExceptionInfo->ExceptionRecord->ExceptionCode == EXCEPTION_ASSERTION_FAILURE && pExceptionInfo->ExceptionRecord->NumberParameters > 0)
        {
            additionalStream.Type = CommentStreamA;
            additionalStream.Buffer = reinterpret_cast<PVOID>(pExceptionInfo->ExceptionRecord->ExceptionInformation[0]);
            additionalStream.BufferSize = static_cast<ULONG>(strlen(reinterpret_cast<char const*>(pExceptionInfo->ExceptionRecord->ExceptionInformation[0])) + 1);

            additionalStreamInfo.UserStreamArray = &additionalStream;
            additionalStreamInfo.UserStreamCount = 1;
        }

        MiniDumpWriteDump(GetCurrentProcess(), GetCurrentProcessId(),
            m_hDumpFile, MiniDumpWithIndirectlyReferencedMemory, &info, &additionalStreamInfo, nullptr);

        CloseHandle(m_hDumpFile);
    }

    if (m_hReportFile)
    {
        PEXCEPTION_RECORD pExceptionRecord = pExceptionInfo->ExceptionRecord;

        Log(_T("====================================================="));
        // Make this red
        spdlog::set_pattern("%^%v%$");
        Log(_T("!!! CRASH !!!"));
        spdlog::set_pattern("%v");

        Log(_T("Exception code: %08X (%s)"),
            pExceptionRecord->ExceptionCode,
            GetExceptionString(pExceptionRecord->ExceptionCode));
        if (pExceptionRecord->ExceptionCode == EXCEPTION_ASSERTION_FAILURE && pExceptionRecord->NumberParameters >= 2)
        {
            pExceptionRecord->ExceptionAddress = reinterpret_cast<PVOID>(pExceptionRecord->ExceptionInformation[1]);
            Log(_T("Assertion message: %s"), pExceptionRecord->ExceptionInformation[0]);
        }

        // Now print information about where the fault occured
        TCHAR szFaultingModule[MAX_PATH];
        DWORD section;
        DWORD_PTR offset;
        GetLogicalAddress(pExceptionRecord->ExceptionAddress,
            szFaultingModule,
            sizeof(szFaultingModule),
            section, offset);

#ifdef _M_IX86
        Log(_T("Fault address: %08X %02X:%08X"),
            pExceptionRecord->ExceptionAddress,
            section, offset);
#endif
#ifdef _M_X64
        Log(_T("Fault address: %016I64X %02X:%016I64X"),
            pExceptionRecord->ExceptionAddress,
            section, offset);
#endif

        Log(_T("Process Name: %s"), GetCommandLineArgsString());
        Log(_T("Full crash report: %s"), m_szLogFileName);
        Log(_T("Memory dump: %s"), m_szDumpFileName);
        Log(_T(fmt::format("Time of crash: {:%Y/%m/%d %H:%M:%S}", earth_time::to_local_tm()).c_str()));
        Log(_T("Process Uptime: %s"), GetUptimeString());
        PrintSystemInfo();
        Log(_T("Process Memory Usage: %s"), GetProcessMemoryUsageString());
        Log(_T("System Memory Usage: %s"), GetSystemMemoryUsageString());
        Log(_T("Git Branch: %s"), version::GetGitBranch());
        Log(_T("Git Commit Subject: %s"), version::GetGitCommitSubject());
        Log(_T("Git SHA: %s"), version::GetGitSha());
        Log(_T("Git Date: %s"), version::GetGitDate());
        Log(_T("====================================================="));

        Log(_T("=== Backtrace ==="));
        for (auto& line : logging::GetBacktrace())
        {
            Log(_T("%s"), line.c_str());
        }

        Log(_T("====================================================="));

        GenerateExceptionReport(pExceptionInfo);
    }

    Log(_T(fmt::format("WheatyUnhandledExceptionFilter Exit").c_str()));

    fclose(m_hReportFile);
    m_hReportFile = nullptr;

    // Pause for a moment to give spdlog a chance to flush
    std::this_thread::sleep_for(200ms);

    TerminateProcess(GetCurrentProcess(), 1);
    return EXCEPTION_EXECUTE_HANDLER; // Unreacheable code
}

void __cdecl WheatyExceptionReport::WheatyCrtHandler(wchar_t const* /*expression*/, wchar_t const* /*function*/, wchar_t const* /*file*/, unsigned int /*line*/, uintptr_t /*pReserved*/)
{
    RaiseException(EXCEPTION_ACCESS_VIOLATION, 0, 0, nullptr);
}

BOOL WheatyExceptionReport::_GetProcessorName(TCHAR* sProcessorName, DWORD maxcount)
{
    if (!sProcessorName)
    {
        return FALSE;
    }

    HKEY hKey;
    LONG lRet;
    lRet = ::RegOpenKeyEx(HKEY_LOCAL_MACHINE, _T("HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0"),
        0, KEY_QUERY_VALUE, &hKey);
    if (lRet != ERROR_SUCCESS)
    {
        return FALSE;
    }

    TCHAR szTmp[2048];
    DWORD cntBytes = sizeof(szTmp);
    lRet = ::RegQueryValueEx(hKey, _T("ProcessorNameString"), nullptr, nullptr,
        (LPBYTE)szTmp, &cntBytes);
    if (lRet != ERROR_SUCCESS)
    {
        return FALSE;
    }

    ::RegCloseKey(hKey);
    sProcessorName[0] = '\0';
    // Skip spaces
    TCHAR* psz = szTmp;
    while (iswspace(*psz))
    {
        ++psz;
    }

    _tcsncpy(sProcessorName, psz, maxcount);
    return TRUE;
}

template<size_t size>
void ToTchar(wchar_t const* src, TCHAR (&dst)[size], std::true_type)
{
    wcstombs_s(nullptr, dst, src, size);
}

template<size_t size>
void ToTchar(wchar_t const* src, TCHAR (&dst)[size], std::false_type)
{
    wcscpy_s(dst, src);
}

BOOL WheatyExceptionReport::_GetWindowsVersion(TCHAR* szVersion, DWORD cntMax)
{
    // Try calling GetVersionEx using the OSVERSIONINFOEX structure.
    // If that fails, try using the OSVERSIONINFO structure.
    RTL_OSVERSIONINFOEXW osvi = { 0 };
    osvi.dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOEXW);
    NTSTATUS bVersionEx = RtlGetVersion((PRTL_OSVERSIONINFOW)&osvi);
    if (bVersionEx < 0)
    {
        osvi.dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOW);
        if (!RtlGetVersion((PRTL_OSVERSIONINFOW)&osvi))
            return FALSE;
    }
    *szVersion = _T('\0');

    TCHAR szCSDVersion[256];
    ToTchar(osvi.szCSDVersion, szCSDVersion, std::is_same<TCHAR, char>::type());

    TCHAR wszTmp[128];
    switch (osvi.dwPlatformId)
    {
        // Windows NT product family.
        case VER_PLATFORM_WIN32_NT:
        {
        #if WINVER < 0x0500
            BYTE suiteMask = osvi.wReserved[0];
            BYTE productType = osvi.wReserved[1];
        #else
            WORD suiteMask = osvi.wSuiteMask;
            BYTE productType = osvi.wProductType;
        #endif                                          // WINVER < 0x0500

            // Test for the specific product family.
            if (osvi.dwMajorVersion == 10)
            {
                if (productType == VER_NT_WORKSTATION)
                    _tcsncat(szVersion, _T("Windows 10 "), cntMax);
                else
                    _tcsncat(szVersion, _T("Windows Server 2016 "), cntMax);
            }
            else if (osvi.dwMajorVersion == 6)
            {
                if (productType == VER_NT_WORKSTATION)
                {
                    if (osvi.dwMinorVersion == 3)
                        _tcsncat(szVersion, _T("Windows 8.1 "), cntMax);
                    else if (osvi.dwMinorVersion == 2)
                        _tcsncat(szVersion, _T("Windows 8 "), cntMax);
                    else if (osvi.dwMinorVersion == 1)
                        _tcsncat(szVersion, _T("Windows 7 "), cntMax);
                    else
                        _tcsncat(szVersion, _T("Windows Vista "), cntMax);
                }
                else if (osvi.dwMinorVersion == 3)
                    _tcsncat(szVersion, _T("Windows Server 2012 R2 "), cntMax);
                else if (osvi.dwMinorVersion == 2)
                    _tcsncat(szVersion, _T("Windows Server 2012 "), cntMax);
                else if (osvi.dwMinorVersion == 1)
                    _tcsncat(szVersion, _T("Windows Server 2008 R2 "), cntMax);
                else
                    _tcsncat(szVersion, _T("Windows Server 2008 "), cntMax);
            }
            else if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 2)
                _tcsncat(szVersion, _T("Microsoft Windows Server 2003 "), cntMax);
            else if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 1)
                _tcsncat(szVersion, _T("Microsoft Windows XP "), cntMax);
            else if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 0)
                _tcsncat(szVersion, _T("Microsoft Windows 2000 "), cntMax);
            else if (osvi.dwMajorVersion <= 4)
                _tcsncat(szVersion, _T("Microsoft Windows NT "), cntMax);

            // Test for specific product on Windows NT 4.0 SP6 and later.
            if (bVersionEx >= 0)
            {
                // Test for the workstation type.
                if (productType == VER_NT_WORKSTATION)
                {
                    if (osvi.dwMajorVersion == 4)
                        _tcsncat(szVersion, _T("Workstation 4.0 "), cntMax);
                    else if (suiteMask & VER_SUITE_PERSONAL)
                        _tcsncat(szVersion, _T("Home Edition "), cntMax);
                    else if (suiteMask & VER_SUITE_EMBEDDEDNT)
                        _tcsncat(szVersion, _T("Embedded "), cntMax);
                    else
                        _tcsncat(szVersion, _T("Professional "), cntMax);
                }
                // Test for the server type.
                else if (productType == VER_NT_SERVER)
                {
                    if (osvi.dwMajorVersion == 6 || osvi.dwMajorVersion == 10)
                    {
                        if (suiteMask & VER_SUITE_SMALLBUSINESS_RESTRICTED)
                            _tcsncat(szVersion, _T("Essentials "), cntMax);
                        else if (suiteMask & VER_SUITE_DATACENTER)
                            _tcsncat(szVersion, _T("Datacenter "), cntMax);
                        else if (suiteMask & VER_SUITE_ENTERPRISE)
                            _tcsncat(szVersion, _T("Enterprise "), cntMax);
                        else
                            _tcsncat(szVersion, _T("Standard "), cntMax);
                    }
                    else if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 2)
                    {
                        if (suiteMask & VER_SUITE_DATACENTER)
                            _tcsncat(szVersion, _T("Datacenter Edition "), cntMax);
                        else if (suiteMask & VER_SUITE_ENTERPRISE)
                            _tcsncat(szVersion, _T("Enterprise Edition "), cntMax);
                        else if (suiteMask == VER_SUITE_BLADE)
                            _tcsncat(szVersion, _T("Web Edition "), cntMax);
                        else
                            _tcsncat(szVersion, _T("Standard Edition "), cntMax);
                    }
                    else if (osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 0)
                    {
                        if (suiteMask & VER_SUITE_DATACENTER)
                            _tcsncat(szVersion, _T("Datacenter Server "), cntMax);
                        else if (suiteMask & VER_SUITE_ENTERPRISE)
                            _tcsncat(szVersion, _T("Advanced Server "), cntMax);
                        else
                            _tcsncat(szVersion, _T("Server "), cntMax);
                    }
                    else                                        // Windows NT 4.0
                    {
                        if (suiteMask & VER_SUITE_ENTERPRISE)
                            _tcsncat(szVersion, _T("Server 4.0, Enterprise Edition "), cntMax);
                        else
                            _tcsncat(szVersion, _T("Server 4.0 "), cntMax);
                    }
                }
            }

            // Display service pack (if any) and build number.
            if (osvi.dwMajorVersion == 4 && _tcsicmp(szCSDVersion, _T("Service Pack 6")) == 0)
            {
                HKEY hKey;
                LONG lRet;

                // Test for SP6 versus SP6a.
                lRet = ::RegOpenKeyEx(HKEY_LOCAL_MACHINE, _T("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Hotfix\\Q246009"), 0, KEY_QUERY_VALUE, &hKey);
                if (lRet == ERROR_SUCCESS)
                {
                    _stprintf(wszTmp, _T("Service Pack 6a (Version %d.%d, Build %d)"),
                        osvi.dwMajorVersion, osvi.dwMinorVersion, osvi.dwBuildNumber & 0xFFFF);
                    _tcsncat(szVersion, wszTmp, cntMax);
                }
                else                                            // Windows NT 4.0 prior to SP6a
                {
                    _stprintf(wszTmp, _T("%s (Version %d.%d, Build %d)"),
                        szCSDVersion, osvi.dwMajorVersion, osvi.dwMinorVersion, osvi.dwBuildNumber & 0xFFFF);
                    _tcsncat(szVersion, wszTmp, cntMax);
                }
                ::RegCloseKey(hKey);
            }
            else                                                // Windows NT 3.51 and earlier or Windows 2000 and later
            {
                if (!_tcslen(szCSDVersion))
                    _stprintf(wszTmp, _T("(Version %d.%d, Build %d)"),
                        osvi.dwMajorVersion, osvi.dwMinorVersion, osvi.dwBuildNumber & 0xFFFF);
                else
                    _stprintf(wszTmp, _T("%s (Version %d.%d, Build %d)"),
                        szCSDVersion, osvi.dwMajorVersion, osvi.dwMinorVersion, osvi.dwBuildNumber & 0xFFFF);
                _tcsncat(szVersion, wszTmp, cntMax);
            }
            break;
        }
        default:
            _stprintf(wszTmp, _T("%s (Version %d.%d, Build %d)"),
                szCSDVersion, osvi.dwMajorVersion, osvi.dwMinorVersion, osvi.dwBuildNumber & 0xFFFF);
            _tcsncat(szVersion, wszTmp, cntMax);
            break;
    }

    return TRUE;
}

void WheatyExceptionReport::PrintSystemInfo()
{
    SYSTEM_INFO SystemInfo;
    ::GetSystemInfo(&SystemInfo);

    MEMORYSTATUS MemoryStatus;
    MemoryStatus.dwLength = sizeof(MEMORYSTATUS);
    ::GlobalMemoryStatus(&MemoryStatus);
    TCHAR sString[1024];
    if (_GetProcessorName(sString, static_cast<DWORD>(std::size(sString))))
    {
        Log(_T("Processor: %s"), sString);
        Log(_T("Number Of Threads: %d"), SystemInfo.dwNumberOfProcessors);
    }
    else
    {
        Log(_T("Processor: <unknown>Number Of Threads: %d"),
            SystemInfo.dwNumberOfProcessors);
    }

    if (_GetWindowsVersion(sString, static_cast<DWORD>(std::size(sString))))
        Log(_T("OS: %s"), sString);
    else
        Log(_T("OS: <unknown>"));
}

//===========================================================================
void WheatyExceptionReport::printTracesForAllThreads(bool bWriteVariables)
{
    THREADENTRY32 te32;

    DWORD dwOwnerPID   = GetCurrentProcessId();
    DWORD dwCurrentTID = GetCurrentThreadId();
    m_hProcess         = GetCurrentProcess();
    // Take a snapshot of all running threads
    HANDLE hThreadSnap = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
    if (hThreadSnap == INVALID_HANDLE_VALUE)
        return;

    // Fill in the size of the structure before using it.
    te32.dwSize = sizeof(THREADENTRY32);

    // Retrieve information about the first thread,
    // and exit if unsuccessful
    if (!Thread32First(hThreadSnap, &te32))
    {
        CloseHandle(hThreadSnap); // Must clean up the
                                  //   snapshot object!
        return;
    }

    // Now walk the thread list of the system,
    // and display information about each thread
    // associated with the specified process
    do
    {
        if (te32.th32OwnerProcessID == dwOwnerPID && te32.th32ThreadID != dwCurrentTID)
        {
            CONTEXT context;
            context.ContextFlags = 0xffffffff;
            HANDLE threadHandle  = OpenThread(THREAD_GET_CONTEXT | THREAD_QUERY_INFORMATION, false, te32.th32ThreadID);
            if (threadHandle)
            {
                if (GetThreadContext(threadHandle, &context))
                    WriteStackDetails(&context, bWriteVariables, threadHandle);
                CloseHandle(threadHandle);
            }
        }
    } while (Thread32Next(hThreadSnap, &te32));

    //  Don't forget to clean up the snapshot object.
    CloseHandle(hThreadSnap);
}

//===========================================================================
// Open the report file, and write the desired information to it.  Called by
// WheatyUnhandledExceptionFilter
//===========================================================================
void WheatyExceptionReport::GenerateExceptionReport(
PEXCEPTION_POINTERS pExceptionInfo)
{
    // __try / __except is for catching SEH (windows generated errors) not for catching general exceptions.
    __try
    {
        PEXCEPTION_RECORD pExceptionRecord = pExceptionInfo->ExceptionRecord;

        PCONTEXT pCtx = pExceptionInfo->ContextRecord;

        /*
        // Show the registers
#ifdef _M_IX86                                          // X86 Only!
        Log(_T("=== Registers ==="));

        Log(_T("EAX:%08XEBX:%08XECX:%08XEDX:%08XESI:%08XEDI:%08X")
            , pCtx->Eax, pCtx->Ebx, pCtx->Ecx, pCtx->Edx,
            pCtx->Esi, pCtx->Edi);

        Log(_T("CS:EIP:%04X:%08X"), pCtx->SegCs, pCtx->Eip);
        Log(_T("SS:ESP:%04X:%08X  EBP:%08X"),
            pCtx->SegSs, pCtx->Esp, pCtx->Ebp);
        Log(_T("DS:%04X  ES:%04X  FS:%04X  GS:%04X"),
            pCtx->SegDs, pCtx->SegEs, pCtx->SegFs, pCtx->SegGs);
        Log(_T("Flags:%08X"), pCtx->EFlags);
#endif

#ifdef _M_X64
        Log(_T("=== Registers ==="));
        Log(_T("RAX:%016I64XRBX:%016I64XRCX:%016I64XRDX:%016I64XRSI:%016I64XRDI:%016I64X")
            _T("R8: %016I64XR9: %016I64XR10:%016I64XR11:%016I64XR12:%016I64XR13:%016I64XR14:%016I64XR15:%016I64X")
            , pCtx->Rax, pCtx->Rbx, pCtx->Rcx, pCtx->Rdx,
            pCtx->Rsi, pCtx->Rdi, pCtx->R9, pCtx->R10, pCtx->R11, pCtx->R12, pCtx->R13, pCtx->R14, pCtx->R15);
        Log(_T("CS:RIP:%04X:%016I64X"), pCtx->SegCs, pCtx->Rip);
        Log(_T("SS:RSP:%04X:%016X  RBP:%08X"),
            pCtx->SegSs, pCtx->Rsp, pCtx->Rbp);
        Log(_T("DS:%04X  ES:%04X  FS:%04X  GS:%04X"),
            pCtx->SegDs, pCtx->SegEs, pCtx->SegFs, pCtx->SegGs);
        Log(_T("Flags:%08X"), pCtx->EFlags);
#endif
        */

        SymSetOptions(SYMOPT_DEFERRED_LOADS);

        // Initialize DbgHelp
        if (!SymInitialize(GetCurrentProcess(), nullptr, TRUE))
        {
            Log(_T("CRITICAL ERROR. Couldn't initialize the symbol handler for process. Error: %s."),
                ErrorMessage(GetLastError()));
        }

        if (pExceptionRecord->ExceptionCode == 0xE06D7363 && pExceptionRecord->NumberParameters >= 2)
        {
            PVOID exceptionObject = reinterpret_cast<PVOID>(pExceptionRecord->ExceptionInformation[1]);
            ThrowInfo const* throwInfo = reinterpret_cast<ThrowInfo const*>(pExceptionRecord->ExceptionInformation[2]);
#if _EH_RELATIVE_TYPEINFO
            // When _EH_RELATIVE_TYPEINFO is defined, the pointers need to be retrieved with some pointer math
            auto resolveExceptionRVA = [pExceptionRecord](int32 rva) -> DWORD_PTR
            {
                return rva + (pExceptionRecord->NumberParameters >= 4 ? pExceptionRecord->ExceptionInformation[3] : 0);
            };
#else
            // Otherwise the pointers are already there in the API types
            auto resolveExceptionRVA = [](void const* input) -> void const* { return input; };
#endif

            CatchableTypeArray const* catchables = reinterpret_cast<CatchableTypeArray const*>(resolveExceptionRVA(throwInfo->pCatchableTypeArray));
            CatchableType const* catchable = catchables->nCatchableTypes ? reinterpret_cast<CatchableType const*>(resolveExceptionRVA(catchables->arrayOfCatchableTypes[0])) : nullptr;
            TypeDescriptor const* exceptionTypeinfo = catchable ? reinterpret_cast<TypeDescriptor const*>(resolveExceptionRVA(catchable->pType)) : nullptr;

            if (exceptionTypeinfo)
            {
                void* stdExceptionTypeInfo = []() -> void*
                {
                    try
                    {
                        std::exception fake;
                        return __RTtypeid(&fake);
                    }
                    catch (...)
                    {
                        return nullptr;
                    }
                }();
                std::exception const* exceptionPtr = [](void* object, TypeDescriptor const* typeInfo, void* stdExceptionTypeInfo) -> std::exception const*
                {
                    try
                    {
                        // real_type descriptor is obtained by parsing throwinfo
                        // equivalent to expression like this
                        // std::exception* e = object;
                        // real_type* r = dynamic_cast<real_type*>(e);
                        // return r;
                        return reinterpret_cast<std::exception const*>(__RTDynamicCast(object, 0, stdExceptionTypeInfo, (void*)typeInfo, false));
                    }
                    catch (...)
                    {
                        return nullptr;
                    }
                }(exceptionObject, exceptionTypeinfo, stdExceptionTypeInfo);

                // dynamic_cast<type>(variable_that_already_has_that_type) is optimized away by compiler and attempting to call __RTDynamicCast fails for it
                if (!exceptionPtr && exceptionTypeinfo == stdExceptionTypeInfo)
                    exceptionPtr = reinterpret_cast<std::exception*>(exceptionObject);

                Log(_T("Uncaught C++ exception info:"));
                if (exceptionPtr)
                    Log(_T(" %s"), exceptionPtr->what());

                //Log(_T(""));

                char undName[MAX_SYM_NAME] = { };
                if (UnDecorateSymbolName(&exceptionTypeinfo->name[1], &undName[0], MAX_SYM_NAME, UNDNAME_32_BIT_DECODE | UNDNAME_NAME_ONLY | UNDNAME_NO_ARGUMENTS))
                {
                    char buf[MAX_SYM_NAME + sizeof(SYMBOL_INFO)] = { };
                    PSYMBOL_INFO sym = (PSYMBOL_INFO)&buf[0];
                    sym->SizeOfStruct = sizeof(SYMBOL_INFO);
                    sym->MaxNameLen = MAX_SYM_NAME;
                    if (SymGetTypeFromName(m_hProcess, (ULONG64)GetModuleHandle(nullptr), undName, sym))
                    {
                        sym->Address = pExceptionRecord->ExceptionInformation[1];
                        sym->Flags = 0;
                        char const* variableName = "uncaught_exception";
                        memset(sym->Name, 0, MAX_SYM_NAME);
                        memcpy(sym->Name, variableName, strlen(variableName));
                        FormatSymbolValue(sym, nullptr);
                    }
                }
            }
        }

        CONTEXT trashableContext = *pCtx;
        WriteStackDetails(&trashableContext, false, nullptr);
        printTracesForAllThreads(false);

        Log(_T("====================================================="));
        Log(_T("=== Full Dumps ==="));

        trashableContext = *pCtx;
        WriteStackDetails(&trashableContext, true, nullptr);
        printTracesForAllThreads(true);

        SymCleanup(GetCurrentProcess());
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
        Log(_T("Error writing the crash log"));
    }
}

//======================================================================
// Given an exception code, returns a pointer to a static string with a
// description of the exception
//======================================================================
LPCTSTR WheatyExceptionReport::GetExceptionString(DWORD dwCode)
{
    #define EXCEPTION(x) case EXCEPTION_##x: return _T(#x);

    switch (dwCode)
    {
        EXCEPTION(ACCESS_VIOLATION)
        EXCEPTION(DATATYPE_MISALIGNMENT)
        EXCEPTION(BREAKPOINT)
        EXCEPTION(SINGLE_STEP)
        EXCEPTION(ARRAY_BOUNDS_EXCEEDED)
        EXCEPTION(FLT_DENORMAL_OPERAND)
        EXCEPTION(FLT_DIVIDE_BY_ZERO)
        EXCEPTION(FLT_INEXACT_RESULT)
        EXCEPTION(FLT_INVALID_OPERATION)
        EXCEPTION(FLT_OVERFLOW)
        EXCEPTION(FLT_STACK_CHECK)
        EXCEPTION(FLT_UNDERFLOW)
        EXCEPTION(INT_DIVIDE_BY_ZERO)
        EXCEPTION(INT_OVERFLOW)
        EXCEPTION(PRIV_INSTRUCTION)
        EXCEPTION(IN_PAGE_ERROR)
        EXCEPTION(ILLEGAL_INSTRUCTION)
        EXCEPTION(NONCONTINUABLE_EXCEPTION)
        EXCEPTION(STACK_OVERFLOW)
        EXCEPTION(INVALID_DISPOSITION)
        EXCEPTION(GUARD_PAGE)
        EXCEPTION(INVALID_HANDLE)
        case 0xE06D7363: return _T("Unhandled C++ exception");
    }

    // If not one of the "known" exceptions, try to get the string
    // from NTDLL.DLL's message table.

    static TCHAR szBuffer[512] = { 0 };

    FormatMessage(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_HMODULE,
        GetModuleHandle(_T("NTDLL.DLL")),
        dwCode, 0, szBuffer, sizeof(szBuffer), nullptr);

    return szBuffer;
}

//=============================================================================
// Given a linear address, locates the module, section, and offset containing
// that address.
//
// Note: the szModule paramater buffer is an output buffer of length specified
// by the len parameter (in characters!)
//=============================================================================
BOOL WheatyExceptionReport::GetLogicalAddress(
PVOID addr, PTSTR szModule, DWORD len, DWORD& section, DWORD_PTR& offset)
{
    MEMORY_BASIC_INFORMATION mbi;

    if (!VirtualQuery(addr, &mbi, sizeof(mbi)))
        return FALSE;

    DWORD_PTR hMod = (DWORD_PTR)mbi.AllocationBase;

    if (!hMod)
        return FALSE;

    if (!GetModuleFileName((HMODULE)hMod, szModule, len))
        return FALSE;

    // Point to the DOS header in memory
    PIMAGE_DOS_HEADER pDosHdr = (PIMAGE_DOS_HEADER)hMod;

    // From the DOS header, find the NT (PE) header
    PIMAGE_NT_HEADERS pNtHdr = (PIMAGE_NT_HEADERS)(hMod + DWORD_PTR(pDosHdr->e_lfanew));

    PIMAGE_SECTION_HEADER pSection = IMAGE_FIRST_SECTION(pNtHdr);

    DWORD_PTR rva = (DWORD_PTR)addr - hMod;                         // RVA is offset from module load address

    // Iterate through the section table, looking for the one that encompasses
    // the linear address.
    for (unsigned i = 0;
        i < pNtHdr->FileHeader.NumberOfSections;
        i++, pSection++)
    {
        DWORD_PTR sectionStart = pSection->VirtualAddress;
        DWORD_PTR sectionEnd = sectionStart
            + DWORD_PTR(std::max(pSection->SizeOfRawData, pSection->Misc.VirtualSize));

        // Is the address in this section???
        if ((rva >= sectionStart) && (rva <= sectionEnd))
        {
            // Yes, address is in the section.  Calculate section and offset,
            // and store in the "section" & "offset" params, which were
            // passed by reference.
            section = i+1;
            offset = rva - sectionStart;
            return TRUE;
        }
    }

    return FALSE;                                           // Should never get here!
}

// It contains SYMBOL_INFO structure plus additional
// space for the name of the symbol
struct CSymbolInfoPackage : public SYMBOL_INFO_PACKAGE
{
    CSymbolInfoPackage()
    {
        si.SizeOfStruct = sizeof(SYMBOL_INFO);
        si.MaxNameLen   = sizeof(name);
    }
};

//============================================================
// Walks the stack, and writes the results to the report file
//============================================================
void WheatyExceptionReport::WriteStackDetails(
PCONTEXT pContext,
bool bWriteVariables, HANDLE pThreadHandle)                                      // true if local/params should be output
{
    Log(_T("=== Call stack ==="));
    Log(_T("Address           Frame             Function"));

    DWORD dwMachineType = 0;
    // Could use SymSetOptions here to add the SYMOPT_DEFERRED_LOADS flag

    STACKFRAME64 sf;
    memset(&sf, 0, sizeof(sf));

    #ifdef _M_IX86
    // Initialize the STACKFRAME structure for the first call.  This is only
    // necessary for Intel CPUs, and isn't mentioned in the documentation.
    sf.AddrPC.Offset       = pContext->Eip;
    sf.AddrPC.Mode         = AddrModeFlat;
    sf.AddrStack.Offset    = pContext->Esp;
    sf.AddrStack.Mode      = AddrModeFlat;
    sf.AddrFrame.Offset    = pContext->Ebp;
    sf.AddrFrame.Mode      = AddrModeFlat;

    dwMachineType = IMAGE_FILE_MACHINE_I386;
    #endif

#ifdef _M_X64
    sf.AddrPC.Offset    = pContext->Rip;
    sf.AddrPC.Mode = AddrModeFlat;
    sf.AddrStack.Offset    = pContext->Rsp;
    sf.AddrStack.Mode      = AddrModeFlat;
    sf.AddrFrame.Offset    = pContext->Rbp;
    sf.AddrFrame.Mode      = AddrModeFlat;
    dwMachineType = IMAGE_FILE_MACHINE_AMD64;
#endif

    for (;;)
    {
        // Get the next stack frame
        if (! StackWalk64(dwMachineType,
            m_hProcess,
            pThreadHandle != nullptr ? pThreadHandle : GetCurrentThread(),
            &sf,
            pContext,
            nullptr,
            SymFunctionTableAccess64,
            SymGetModuleBase64,
            nullptr))
            break;
        if (0 == sf.AddrFrame.Offset)                     // Basic sanity check to make sure
            break;                                          // the frame is OK.  Bail if not.

        DWORD64 symDisplacement = 0;                        // Displacement of the input address,
        // relative to the start of the symbol

        std::array<wchar_t, 1024> funcNameBuffer{};

        // Get the name of the function for this stack frame entry
        CSymbolInfoPackage sip;
        if (SymFromAddr(
            m_hProcess,                                     // Process handle of the current process
            sf.AddrPC.Offset,                               // Symbol address
            &symDisplacement,                               // Address of the variable that will receive the displacement
            &sip.si))                                       // Address of the SYMBOL_INFO structure (inside "sip" object)
        {
            bool isStdLib = sip.si.NameLen > 3 &&
                            sip.si.Name[0] == 's' &&
                            sip.si.Name[1] == 't' &&
                            sip.si.Name[2] == 'd';

            // Don't print things from the std:: namespace, for clarity
            if (isStdLib)
            {
                continue;
            }

            wsprintf((LPSTR)funcNameBuffer.data(), "%hs+%I64X", sip.si.Name, symDisplacement);
        }
        else                                                // No symbol found.  Print out the logical address instead.
        {
            TCHAR szModule[MAX_PATH] = _T("");
            DWORD section = 0;
            DWORD_PTR offset = 0;

            GetLogicalAddress((PVOID)sf.AddrPC.Offset,
                szModule, sizeof(szModule), section, offset);
#ifdef _M_IX86
            wsprintf((LPSTR)funcNameBuffer.data(), "%04X:%08X %s", section, offset, szModule);
#endif
#ifdef _M_X64
            wsprintf((LPSTR)funcNameBuffer.data(), "%04X:%016I64X %s", section, offset, szModule);
#endif
        }

        // Get the source line for this stack frame entry
        std::array<wchar_t, 1024> fileNameBuffer{};
        IMAGEHLP_LINE64 lineInfo = { sizeof(IMAGEHLP_LINE64) };
        DWORD dwLineDisplacement;
        if (SymGetLineFromAddr64(m_hProcess, sf.AddrPC.Offset,
            &dwLineDisplacement, &lineInfo))
        {
            wsprintf((LPSTR)fileNameBuffer.data(), "%s, line %i", lineInfo.FileName, lineInfo.LineNumber);
        }

#ifdef _M_IX86
        Log(_T("%08X  %08X  %s (%s)"), (DWORD)sf.AddrPC.Offset, (DWORD)sf.AddrFrame.Offset, funcNameBuffer.data(), fileNameBuffer.data());
#endif
#ifdef _M_X64
        Log(_T("%016I64X  %016I64X  %s (%s)"), sf.AddrPC.Offset, sf.AddrFrame.Offset, funcNameBuffer.data(), fileNameBuffer.data());
#endif

        // Write out the variables, if desired
        if (bWriteVariables)
        {
            // Use SymSetContext to get just the locals/params for this frame
            IMAGEHLP_STACK_FRAME imagehlpStackFrame;
            imagehlpStackFrame.InstructionOffset = sf.AddrPC.Offset;
            SymSetContext(m_hProcess, &imagehlpStackFrame, nullptr);

            // Enumerate the locals/parameters
            SymEnumSymbols(m_hProcess, 0, nullptr, EnumerateSymbolsCallback, &sf);
        }
    }

    // Only log one of these to the console, but keep logging the rest to the file
    if (gLogToConsole)
    {
        gLogToConsole = false;
    }
}

//////////////////////////////////////////////////////////////////////////////
// The function invoked by SymEnumSymbols
//////////////////////////////////////////////////////////////////////////////

BOOL CALLBACK
WheatyExceptionReport::EnumerateSymbolsCallback(
PSYMBOL_INFO  pSymInfo,
ULONG         /*SymbolSize*/,
PVOID         UserContext)
{
    // __try / __except is for catching SEH (windows generated errors) not for catching general exceptions.
    __try
    {
        ClearSymbols();
        FormatSymbolValue(pSymInfo, (STACKFRAME64*)UserContext);
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
        Log(_T("punting on symbol %s, partial output:"), pSymInfo->Name);
    }

    return TRUE;
}

//////////////////////////////////////////////////////////////////////////////
// Given a SYMBOL_INFO representing a particular variable, displays its
// contents.  If it's a user defined type, display the members and their
// values.
//////////////////////////////////////////////////////////////////////////////
bool WheatyExceptionReport::FormatSymbolValue(
PSYMBOL_INFO pSym,
STACKFRAME64* sf)
{
    if (!pSym || !sf)
    {
        return false;
    }

    // If it's a function, don't do anything.
    if (pSym->Tag == SymTagFunction)                      // SymTagFunction from CVCONST.H from the DIA SDK
        return false;

    DWORD_PTR pVariable = 0;                                // Will point to the variable's data in memory

    if (pSym->Flags & IMAGEHLP_SYMBOL_INFO_REGRELATIVE)
    {
        // if (pSym->Register == 8)   // EBP is the value 8 (in DBGHELP 5.1)
        {                                                   //  This may change!!!
#ifdef _M_IX86
            pVariable = sf->AddrFrame.Offset;
#elif _M_X64
            pVariable = sf->AddrStack.Offset;
#endif
            pVariable += (DWORD_PTR)pSym->Address;
        }
        // else
        //  return false;
    }
    else if (pSym->Flags & IMAGEHLP_SYMBOL_INFO_REGISTER)
        return false;                                       // Don't try to report register variable
    else
    {
        pVariable = (DWORD_PTR)pSym->Address;               // It must be a global variable
    }

    PushSymbolDetail();

    // Indicate if the variable is a local or parameter
    if (pSym->Flags & IMAGEHLP_SYMBOL_INFO_PARAMETER)
        symbolDetails.top().Prefix = "    Param ";
    else if (pSym->Flags & IMAGEHLP_SYMBOL_INFO_LOCAL)
        symbolDetails.top().Prefix = "    Local ";

    // Determine if the variable is a user defined type (UDT).  IF so, bHandled
    // will return true.
    bool bHandled;
    DumpTypeIndex(pSym->ModBase, pSym->TypeIndex, pVariable, bHandled, pSym->Name, "", false, true);

    if (!bHandled)
    {
        // The symbol wasn't a UDT, so do basic, stupid formatting of the
        // variable.  Based on the size, we're assuming it's a char, WORD, or
        // DWORD.
        BasicType basicType = GetBasicType(pSym->TypeIndex, pSym->ModBase);
        if (symbolDetails.top().Type.empty())
            symbolDetails.top().Type = rgBaseType[basicType];

        // Emit the variable name
        if (pSym->Name[0] != '\0')
            symbolDetails.top().Name = pSym->Name;

        char buffer[50];
        FormatOutputValue(buffer, basicType, pSym->Size, (PVOID)pVariable, sizeof(buffer));
        symbolDetails.top().Value = buffer;
    }

    PopSymbolDetail();
    return true;
}

//////////////////////////////////////////////////////////////////////////////
// If it's a user defined type (UDT), recurse through its members until we're
// at fundamental types.  When he hit fundamental types, return
// bHandled = false, so that FormatSymbolValue() will format them.
//////////////////////////////////////////////////////////////////////////////
void WheatyExceptionReport::DumpTypeIndex(
DWORD64 modBase,
DWORD dwTypeIndex,
DWORD_PTR offset,
bool & bHandled,
char const* Name,
char const* /*suffix*/,
bool newSymbol,
bool logChildren)
{
    bHandled = false;

    if (newSymbol)
        PushSymbolDetail();

    DWORD typeTag;
    if (!SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_SYMTAG, &typeTag))
        return;

    // Get the name of the symbol.  This will either be a Type name (if a UDT),
    // or the structure member name.
    WCHAR * pwszTypeName;
    if (SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_SYMNAME,
        &pwszTypeName))
    {
        // handle special cases
        if (wcscmp(pwszTypeName, L"std::basic_string<char,std::char_traits<char>,std::allocator<char> >") == 0)
        {
            LocalFree(pwszTypeName);
            symbolDetails.top().Type = "std::string";
            char buffer[50];
            FormatOutputValue(buffer, btStdString, 0, (PVOID)offset, sizeof(buffer));
            symbolDetails.top().Value = buffer;
            if (Name != nullptr && Name[0] != '\0')
                symbolDetails.top().Name = Name;
            bHandled = true;
            return;
        }

        char buffer[WER_SMALL_BUFFER_SIZE];
        wcstombs(buffer, pwszTypeName, sizeof(buffer));
        buffer[WER_SMALL_BUFFER_SIZE - 1] = '\0';
        if (Name != nullptr && Name[0] != '\0')
        {
            symbolDetails.top().Type = buffer;
            symbolDetails.top().Name = Name;
        }
        else if (buffer[0] != '\0')
            symbolDetails.top().Name = buffer;

        LocalFree(pwszTypeName);
    }
    else if (Name != nullptr && Name[0] != '\0')
        symbolDetails.top().Name = Name;

    if (!StoreSymbol(dwTypeIndex, offset))
    {
        // Skip printing address and base class if it has been printed already
        if (typeTag == SymTagBaseClass)
            bHandled = true;
        return;
    }

    DWORD innerTypeID;
    switch (typeTag)
    {
        case SymTagPointerType:
            if (SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_TYPEID, &innerTypeID))
            {
                if (Name != nullptr && Name[0] != '\0')
                    symbolDetails.top().Name = Name;

                BOOL isReference;
                SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_IS_REFERENCE, &isReference);

                char addressStr[40];
                memset(addressStr, 0, sizeof(addressStr));

                if (isReference)
                    symbolDetails.top().Suffix += "&";
                else
                    symbolDetails.top().Suffix += "*";

                // Try to dereference the pointer in a try/except block since it might be invalid
                DWORD_PTR address = DereferenceUnsafePointer(offset);

                char buffer[WER_SMALL_BUFFER_SIZE];
                FormatOutputValue(buffer, btVoid, sizeof(PVOID), (PVOID)offset, sizeof(buffer));
                symbolDetails.top().Value = buffer;

                if (symbolDetails.size() >= WER_MAX_NESTING_LEVEL)
                    logChildren = false;

                // no need to log any children since the address is invalid anyway
                if (address == 0 || address == DWORD_PTR(-1))
                    logChildren = false;

                DumpTypeIndex(modBase, innerTypeID, address, bHandled, Name, addressStr, false, logChildren);

                if (!bHandled)
                {
                    BasicType basicType = GetBasicType(dwTypeIndex, modBase);
                    if (symbolDetails.top().Type.empty())
                        symbolDetails.top().Type = rgBaseType[basicType];

                    if (address == 0)
                        symbolDetails.top().Value = "NULL";
                    else if (address == DWORD_PTR(-1))
                        symbolDetails.top().Value = "<Unable to read memory>";
                    else
                    {
                        // Get the size of the child member
                        ULONG64 length;
                        SymGetTypeInfo(m_hProcess, modBase, innerTypeID, TI_GET_LENGTH, &length);
                        char buffer2[50];
                        FormatOutputValue(buffer2, basicType, length, (PVOID)address, sizeof(buffer2));
                        symbolDetails.top().Value = buffer2;
                    }
                    bHandled = true;
                    return;
                }
                else if (address == 0)
                    symbolDetails.top().Value = "NULL";
                else if (address == DWORD_PTR(-1))
                {
                    symbolDetails.top().Value = "<Unable to read memory>";
                    bHandled = true;
                    return;
                }
            }
            break;
        case SymTagData:
            if (SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_TYPEID, &innerTypeID))
            {
                DWORD innerTypeTag;
                if (!SymGetTypeInfo(m_hProcess, modBase, innerTypeID, TI_GET_SYMTAG, &innerTypeTag))
                    break;

                switch (innerTypeTag)
                {
                    case SymTagUDT:
                        if (symbolDetails.size() >= WER_MAX_NESTING_LEVEL)
                            logChildren = false;
                        DumpTypeIndex(modBase, innerTypeID,
                            offset, bHandled, symbolDetails.top().Name.c_str(), "", false, logChildren);
                        break;
                    case SymTagPointerType:
                        if (Name != nullptr && Name[0] != '\0')
                            symbolDetails.top().Name = Name;
                        DumpTypeIndex(modBase, innerTypeID,
                            offset, bHandled, symbolDetails.top().Name.c_str(), "", false, logChildren);
                        break;
                    case SymTagArrayType:
                        DumpTypeIndex(modBase, innerTypeID,
                            offset, bHandled, symbolDetails.top().Name.c_str(), "", false, logChildren);
                        break;
                    default:
                        break;
                }
            }
            break;
        case SymTagArrayType:
            if (SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_TYPEID, &innerTypeID))
            {
                symbolDetails.top().HasChildren = true;

                BasicType basicType = btNoType;
                DumpTypeIndex(modBase, innerTypeID,
                    offset, bHandled, Name, "", false, false);

                // Set Value back to an empty string since the Array object itself has no value, only its elements have
                std::string firstElementValue = symbolDetails.top().Value;
                symbolDetails.top().Value.clear();

                DWORD elementsCount;
                if (SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_COUNT, &elementsCount))
                    symbolDetails.top().Suffix += "[" + std::to_string(elementsCount) + "]";
                else
                    symbolDetails.top().Suffix += "[<unknown count>]";

                if (!bHandled)
                {
                    basicType = GetBasicType(dwTypeIndex, modBase);
                    if (symbolDetails.top().Type.empty())
                        symbolDetails.top().Type = rgBaseType[basicType];
                    bHandled = true;
                }

                // Get the size of the child member
                ULONG64 length;
                SymGetTypeInfo(m_hProcess, modBase, innerTypeID, TI_GET_LENGTH, &length);

                char buffer[50];
                switch (basicType)
                {
                    case btChar:
                    case btStdString:
                        FormatOutputValue(buffer, basicType, length, (PVOID)offset, sizeof(buffer), elementsCount);
                        symbolDetails.top().Value = buffer;
                        break;
                    default:
                        for (DWORD index = 0; index < elementsCount && index < WER_MAX_ARRAY_ELEMENTS_COUNT; index++)
                        {
                            bool elementHandled = false;
                            PushSymbolDetail();
                            if (index == 0)
                            {
                                if (firstElementValue.empty())
                                {
                                    FormatOutputValue(buffer, basicType, length, (PVOID)(offset + length * index), sizeof(buffer));
                                    firstElementValue = buffer;
                                }
                                symbolDetails.top().Value = firstElementValue;
                            }
                            else
                            {
                                DumpTypeIndex(modBase, innerTypeID, offset + length * index, elementHandled, "", "", false, false);
                                if (!elementHandled)
                                {
                                    FormatOutputValue(buffer, basicType, length, (PVOID)(offset + length * index), sizeof(buffer));
                                    symbolDetails.top().Value = buffer;
                                }
                            }
                            symbolDetails.top().Prefix.clear();
                            symbolDetails.top().Type.clear();
                            symbolDetails.top().Suffix = "    [" + std::to_string(index) + "]";
                            symbolDetails.top().Name.clear();
                            PopSymbolDetail();
                        }
                        break;
                }

                return;
            }
            break;
        case SymTagBaseType:
            break;
        case SymTagEnum:
            return;
        default:
            break;
    }

    // Determine how many children this type has.
    DWORD dwChildrenCount = 0;
    SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_GET_CHILDRENCOUNT, &dwChildrenCount);

    if (!dwChildrenCount)                                 // If no children, we're done
        return;

    // Prepare to get an array of "TypeIds", representing each of the children.
    // SymGetTypeInfo(TI_FINDCHILDREN) expects more memory than just a
    // TI_FINDCHILDREN_PARAMS struct has.  Use derivation to accomplish this.
    struct FINDCHILDREN : TI_FINDCHILDREN_PARAMS
    {
        ULONG   MoreChildIds[1024*2] = {};
        FINDCHILDREN(){Count = sizeof(MoreChildIds) / sizeof(MoreChildIds[0]);}
    } children;

    children.Count = dwChildrenCount;
    children.Start= 0;

    // Get the array of TypeIds, one for each child type
    if (!SymGetTypeInfo(m_hProcess, modBase, dwTypeIndex, TI_FINDCHILDREN,
        &children))
    {
        return;
    }

    // Iterate through each of the children
    for (unsigned i = 0; i < dwChildrenCount; i++)
    {
        DWORD symTag;
        SymGetTypeInfo(m_hProcess, modBase, children.ChildId[i], TI_GET_SYMTAG, &symTag);

        if (symTag == SymTagFunction ||
            symTag == SymTagEnum ||
            symTag == SymTagTypedef ||
            symTag == SymTagVTable)
            continue;

        // Ignore static fields
        DWORD dataKind;
        SymGetTypeInfo(m_hProcess, modBase, children.ChildId[i], TI_GET_DATAKIND, &dataKind);
        if (dataKind == DataIsStaticLocal ||
            dataKind == DataIsGlobal ||
            dataKind == DataIsStaticMember)
            continue;

        symbolDetails.top().HasChildren = true;
        if (!logChildren)
        {
            bHandled = false;
            return;
        }

        // Recurse for each of the child types
        bool bHandled2;
        BasicType basicType = GetBasicType(children.ChildId[i], modBase);

        // Get the offset of the child member, relative to its parent
        DWORD dwMemberOffset;
        SymGetTypeInfo(m_hProcess, modBase, children.ChildId[i],
            TI_GET_OFFSET, &dwMemberOffset);

        // Calculate the address of the member
        DWORD_PTR dwFinalOffset = offset + dwMemberOffset;

        DumpTypeIndex(modBase,
            children.ChildId[i],
            dwFinalOffset, bHandled2, ""/*Name */, "", true, true);

        // If the child wasn't a UDT, format it appropriately
        if (!bHandled2)
        {
            if (symbolDetails.top().Type.empty())
                symbolDetails.top().Type = rgBaseType[basicType];

            // Get the real "TypeId" of the child.  We need this for the
            // SymGetTypeInfo(TI_GET_TYPEID) call below.
            DWORD typeId;
            SymGetTypeInfo(m_hProcess, modBase, children.ChildId[i],
                TI_GET_TYPEID, &typeId);

            // Get the size of the child member
            ULONG64 length;
            SymGetTypeInfo(m_hProcess, modBase, typeId, TI_GET_LENGTH, &length);

            char buffer[50];
            FormatOutputValue(buffer, basicType, length, (PVOID)dwFinalOffset, sizeof(buffer));
            symbolDetails.top().Value = buffer;
        }

        PopSymbolDetail();
    }

    bHandled = true;
}

void WheatyExceptionReport::FormatOutputValue(char * pszCurrBuffer,
BasicType basicType,
DWORD64 length,
PVOID pAddress,
size_t bufferSize,
size_t countOverride)
{
    // __try / __except is for catching SEH (windows generated errors) not for catching general exceptions.
    __try
    {
        switch (basicType)
        {
            case btChar:
            {
                // Special case handling for char[] type
                if (countOverride != 0)
                    length = countOverride;
                else
                    length = strlen((char*)pAddress);
                if (length > bufferSize - 6)
                    pszCurrBuffer += sprintf(pszCurrBuffer, "\"%.*s...\"", (DWORD)(bufferSize - 6), (char*)pAddress);
                else
                    pszCurrBuffer += sprintf(pszCurrBuffer, "\"%.*s\"", (DWORD)length, (char*)pAddress);
                break;
            }
            case btStdString:
            {
                std::string* value = static_cast<std::string*>(pAddress);
                if (value->length() > bufferSize - 6)
                    pszCurrBuffer += sprintf(pszCurrBuffer, "\"%.*s...\"", (DWORD)(bufferSize - 6), value->c_str());
                else
                    pszCurrBuffer += sprintf(pszCurrBuffer, "\"%s\"", value->c_str());
                break;
            }
            default:
                // Format appropriately (assuming it's a 1, 2, or 4 bytes (!!!)
                if (length == 1)
                    pszCurrBuffer += sprintf(pszCurrBuffer, "0x%X", *(PBYTE)pAddress);
                else if (length == 2)
                    pszCurrBuffer += sprintf(pszCurrBuffer, "0x%X", *(PWORD)pAddress);
                else if (length == 4)
                {
                    if (basicType == btFloat)
                        pszCurrBuffer += sprintf(pszCurrBuffer, "%f", *(PFLOAT)pAddress);
                    else
                        pszCurrBuffer += sprintf(pszCurrBuffer, "0x%X", *(PDWORD)pAddress);
                }
                else if (length == 8)
                {
                    if (basicType == btFloat)
                    {
                        pszCurrBuffer += sprintf(pszCurrBuffer, "%f",
                            *(double *)pAddress);
                    }
                    else
                        pszCurrBuffer += sprintf(pszCurrBuffer, "0x%I64X",
                        *(DWORD64*)pAddress);
                }
                else
                {
    #if _WIN64
                    pszCurrBuffer += sprintf(pszCurrBuffer, "0x%I64X", (DWORD64)pAddress);
    #else
                    pszCurrBuffer += sprintf(pszCurrBuffer, "0x%X", (DWORD)pAddress);
    #endif
                }
                break;
        }
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
#if _WIN64
        pszCurrBuffer += sprintf(pszCurrBuffer, "0x%I64X <Unable to read memory>", (DWORD64)pAddress);
#else
        pszCurrBuffer += sprintf(pszCurrBuffer, "0x%X <Unable to read memory>", (DWORD)pAddress);
#endif
    }
}

BasicType
WheatyExceptionReport::GetBasicType(DWORD typeIndex, DWORD64 modBase)
{
    BasicType basicType;
    if (SymGetTypeInfo(m_hProcess, modBase, typeIndex,
        TI_GET_BASETYPE, &basicType))
    {
        return basicType;
    }

    // Get the real "TypeId" of the child.  We need this for the
    // SymGetTypeInfo(TI_GET_TYPEID) call below.
    DWORD typeId;
    if (SymGetTypeInfo(m_hProcess, modBase, typeIndex, TI_GET_TYPEID, &typeId))
    {
        if (SymGetTypeInfo(m_hProcess, modBase, typeId, TI_GET_BASETYPE,
            &basicType))
        {
            return basicType;
        }
    }

    return btNoType;
}

DWORD_PTR WheatyExceptionReport::DereferenceUnsafePointer(DWORD_PTR address)
{
    // __try / __except is for catching SEH (windows generated errors) not for catching general exceptions.
    __try
    {
        return *(PDWORD_PTR)address;
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
        return DWORD_PTR(-1);
    }
}

//============================================================================
// Helper function that writes to the report file, and allows the user to use
// printf style formating
//============================================================================
int __cdecl WheatyExceptionReport::Log(const TCHAR* format, ...)
{
    std::array<char, 1024> formatted;

    va_list argptr;
    va_start(argptr, format);
    _vsntprintf((TCHAR*)formatted.data(), formatted.size(), format, argptr);
    va_end(argptr);

    std::string outString(formatted.data());
    rtrim(outString);

    if (!outString.empty())
    {
        // Log to file
        fprintf(m_hReportFile, (outString + "\n").data());

        // Log to console
        if (gLogToConsole)
        {
            ShowCritical(outString.c_str());
        }
    }

    return EXCEPTION_EXECUTE_HANDLER;
}

bool WheatyExceptionReport::StoreSymbol(DWORD type, DWORD_PTR offset)
{
    return symbols.insert(SymbolPair(type, offset)).second;
}

void WheatyExceptionReport::ClearSymbols()
{
    symbols.clear();
    while (!symbolDetails.empty())
        symbolDetails.pop();
}

void WheatyExceptionReport::PushSymbolDetail()
{
    // Log current symbol and then add another to the stack to keep the hierarchy format
    PrintSymbolDetail();
    symbolDetails.emplace();
}

void WheatyExceptionReport::PopSymbolDetail()
{
    PrintSymbolDetail();
    symbolDetails.pop();
}

void WheatyExceptionReport::PrintSymbolDetail()
{
    if (symbolDetails.empty())
        return;

    // Don't log anything if has been logged already or if it's empty
    if (symbolDetails.top().Logged || symbolDetails.top().empty())
        return;

    // Add appropriate indentation level (since this routine is recursive)
    for (size_t i = 0; i < symbolDetails.size(); i++)
        Log(_T("    "));

    Log(_T("%s"), symbolDetails.top().ToString().c_str());
}

std::string SymbolDetail::ToString()
{
    Logged = true;
    std::string formatted = Prefix + Type + Suffix;
    if (!Name.empty())
    {
        if (!formatted.empty())
            formatted += " ";
        formatted += Name;
    }
    if (!Value.empty())
    {
        if (Name == "passwd" || Name == "password")
            Value = "<sensitive data>";
        formatted += " = " + Value;
    }
    return formatted;
}

// clang-format on
