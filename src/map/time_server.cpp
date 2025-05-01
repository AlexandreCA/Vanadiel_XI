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

#include "time_server.h"

#include "common/logging.h"
#include "common/vana_time.h"

#include "common/vana_time.h"
#include "daily_system.h"
#include "entities/charentity.h"
#include "latent_effect_container.h"
#include "lua/luautils.h"
#include "roe.h"
#include "timetriggers.h"
#include "transport.h"
#include "utils/guildutils.h"
#include "utils/instanceutils.h"
#include "utils/moduleutils.h"
#include "utils/zoneutils.h"

int32 time_server(timer::time_point tick, CTaskManager::CTask* PTask)
{
    TracyZoneScoped;
    TIMETYPE VanadielTOTD = CVanaTime::getInstance()->SyncTime();
    auto     currentTime  = earth_time::now();
    auto     jstMinute    = earth_time::jst::get_minute(currentTime);
    auto     jstHour      = earth_time::jst::get_hour(currentTime);
    auto     jstWeekday   = earth_time::jst::get_weekday(currentTime);
    // uint8 WeekDay = (uint8)CVanaTime::getInstance()->getWeekday();

    // Weekly update for conquest (sunday at midnight)
    static timer::time_point lastConquestTally  = tick - 1h;
    static timer::time_point lastConquestUpdate = tick - 1h;
    static timer::time_point lastZnmPriceDecay  = tick - 1h;

    if (jstWeekday == 1 && jstHour == 0 && jstMinute == 0)
    {
        if (tick > (lastConquestTally + 1h))
        {
            roeutils::CycleWeeklyRecords();
            roeutils::CycleUnityRankings();
            lastConquestTally = tick;
        }
    }
    // Hourly conquest update
    else if (jstMinute == 0)
    {
        if (tick > (lastConquestUpdate + 1h))
        {
            roeutils::UpdateUnityRankings();
            lastConquestUpdate = tick;
        }

        // ZNM Pop-Item Prices Decay every 2 hours
        if (jstHour % 2 == 0)
        {
            if (tick > (lastZnmPriceDecay + 1h))
            {
                luautils::ZNMPopPriceDecay();
                lastZnmPriceDecay = tick;
            }
        }
    }

    // Vanadiel Hour
    static timer::time_point lastVHourlyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getMinute() == 0)
    {
        if (tick > (lastVHourlyUpdate + 4800ms))
        {
            // clang-format off
            zoneutils::ForEachZone([](CZone* PZone)
            {
                luautils::OnGameHour(PZone);
                PZone->ForEachChar([](CCharEntity* PChar)
                {
                    PChar->PLatentEffectContainer->CheckLatentsHours();
                    PChar->PLatentEffectContainer->CheckLatentsMoonPhase();
                });
            });
            // clang-format on

            lastVHourlyUpdate = tick;
        }
    }

    // JST Midnight
    static timer::time_point lastTickedJstMidnight = tick - 1h;
    if (jstHour == 0 && jstMinute == 0)
    {
        if (tick > (lastTickedJstMidnight + 1h))
        {
            if (settings::get<bool>("main.ENABLE_ROE"))
            {
                roeutils::CycleDailyRecords();
            }

            guildutils::UpdateGuildPointsPattern();
            luautils::OnJSTMidnight();
            luautils::UpdateSanrakusMobs();
            lastTickedJstMidnight = tick;
        }
    }

    // 4-hour RoE Timed blocks
    static timer::time_point lastTickedRoeBlock = tick - 1h;
    if (jstHour % 4 == 0 && jstMinute == 0)
    {
        if (tick > (lastTickedRoeBlock + 1h))
        {
            roeutils::CycleTimedRecords();
            lastTickedRoeBlock = tick;
        }
    }

    // Vanadiel Day
    static timer::time_point lastVDailyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getHour() == 0 && CVanaTime::getInstance()->getMinute() == 0)
    {
        TracyZoneScoped;
        if (tick > (lastVDailyUpdate + 4800ms))
        {
            // clang-format off
            zoneutils::ForEachZone([](CZone* PZone)
            {
                luautils::OnGameDay(PZone);
                PZone->ForEachChar([](CCharEntity* PChar)
                {
                    PChar->PLatentEffectContainer->CheckLatentsWeekDay();
                });
            });
            // clang-format on

            guildutils::UpdateGuildsStock();
            zoneutils::SavePlayTime();

            lastVDailyUpdate = tick;
        }
    }

    // Some notable time-event has occurred. -- CVanaTime::SyncTime() has hit a time of day where latents trigger
    if (VanadielTOTD != TIME_NONE)
    {
        TracyZoneScoped;
        zoneutils::TOTDChange(VanadielTOTD);

        // clang-format off
        zoneutils::ForEachZone([](CZone* PZone)
        {
            PZone->ForEachChar([](CCharEntity* PChar)
            {
                PChar->PLatentEffectContainer->CheckLatentsDay();
                PChar->PLatentEffectContainer->CheckLatentsJobLevel(); // Eerie CLoak +1 latent is nighttime + level multiple of 13
            });
        });
        // clang-format on

        fishingutils::RestockFishingAreas();
    }

    CTriggerHandler::getInstance()->triggerTimer();
    CTransportHandler::getInstance()->TransportTimer();

    instanceutils::CheckInstance();

    luautils::OnTimeServerTick();

    luautils::TryReloadFilewatchList();

    moduleutils::OnTimeServerTick();

    TracyFrameMark;
    return 0;
}
