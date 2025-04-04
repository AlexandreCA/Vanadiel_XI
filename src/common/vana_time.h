﻿/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#pragma once

#ifdef _WIN32
#define timegm _mkgmtime
#endif

#define VTIME_BASEDATE 1009810800 // unix epoch - 1009810800 = se epoch (in earth seconds)
#define VTIME_YEAR     518400     // 360 * GameDay
#define VTIME_MONTH    43200      // 30 * GameDay
#define VTIME_WEEK     11520      // 8 * GameDay
#define VTIME_DAY      1440       // 24 hours * GameHour
#define VTIME_HOUR     60         // 60 minutes

#define JST_OFFSET 32400 // JST +offset from UTC

#include "cbasetypes.h"
#include "singleton.h"

enum DAYTYPE : uint8
{
    FIRESDAY     = 0,
    EARTHSDAY    = 1,
    WATERSDAY    = 2,
    WINDSDAY     = 3,
    ICEDAY       = 4,
    LIGHTNINGDAY = 5,
    LIGHTSDAY    = 6,
    DARKSDAY     = 7
};

enum TIMETYPE : uint8
{
    TIME_NONE     = 0,
    TIME_MIDNIGHT = 1,
    TIME_NEWDAY   = 2,
    TIME_DAWN     = 3,
    TIME_DAY      = 4,
    TIME_DUSK     = 5,
    TIME_EVENING  = 6,
    TIME_NIGHT    = 7
};

class CVanaTime : public Singleton<CVanaTime>
{
public:
    TIMETYPE SyncTime();
    TIMETYPE GetCurrentTOTD();

    uint32 getDate() const;
    uint32 getYear() const;
    uint32 getMonth() const;
    uint32 getDayOfTheMonth() const;
    uint32 getHour() const;
    uint32 getMinute() const;
    uint32 getWeekday() const;
    uint32 getMoonPhase() const;
    uint8  getMoonDirection() const;
    uint8  getRSERace() const;
    uint8  getRSELocation() const;
    uint32 getSysTime();
    uint32 getSysHour();
    uint32 getSysMinute();
    uint32 getSysSecond();
    uint32 getSysWeekDay(); // Number of day since sunday
    uint32 getSysYearDay(); // Number of day since 1st january
    uint32 getJstHour();
    uint32 getJstMinute();
    uint32 getJstSecond();
    uint32 getJstWeekDay(); // Number of day since sunday
    uint32 getJstDayOfMonth();
    uint32 getJstYearDay();  // Number of day since 1st january
    uint32 getJstMidnight(); // Upcoming JST midnight in unix timestamp

    uint32 getVanaTime() const;
    uint32 getEpoch() const;
    uint32 getCustomEpoch() const;

    void setCustomEpoch(int32 epoch);

protected:
    CVanaTime();

private:
    uint32 m_vYear{};    // Vanadiel Year
    uint32 m_vMon{};     // Vanadiel Month
    uint32 m_vDate{};    // Vanadiel Date (day of the month)
    uint32 m_vHour{};    // Vanadiel Hour
    uint32 m_vMin{};     // Vanadiel Minute
    uint32 m_vDay{};     // Vanadiel day of the week (fire, earth, wind, water, ice, lightning, light, dark)
    uint32 m_vanaDate{}; // Vanadiel time in integer format

    TIMETYPE m_TimeType{}; // The current type of time

    int32 m_customEpoch{}; // Custom epoch to use instead of VTIME_BASEDATE
};
