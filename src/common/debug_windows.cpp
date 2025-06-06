﻿/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifdef _WIN32
#include "debug.h"

#include "WheatyExceptionReport.h"

#include <shlobj_core.h>
#pragma comment(lib, "shell32.lib")
#pragma comment(lib, "user32.lib")

WheatyExceptionReport g_WheatyExceptionReport;

void debug::init()
{
    g_WheatyExceptionReport = WheatyExceptionReport();
}

bool debug::isRunningUnderDebugger()
{
    return IsDebuggerPresent();
}

bool debug::isUserRoot()
{
    // There is no root user on Windows, so we check for admin instead
    return IsUserAnAdmin();
}

#endif // _WIN32
