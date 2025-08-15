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

#include "pch.h"

#include "common/application.h"
#include "common/timer.h"
#include "common/watchdog.h"

#include "common/ipp.h"
#include "zone.h"

//
// Forward Declarations
//

class IPP;
class SqlConnection;
class MapNetworking;
class MapStatistics;
class CZone;

struct MapConfig final
{
    IPP  ipp{};
    bool inCI{ false };
};

//
// Exposed globals
//

extern std::unique_ptr<SqlConnection> _sql;
extern std::map<uint16, CZone*>       g_PZoneList; // Global array of pointers for zones

class MapEngine final : public Engine
{
public:
    MapEngine(asio::io_context& io_context, MapConfig& config);
    ~MapEngine() override;

    void gameLoop(asio::io_context& io_context);

    //
    // Init
    //

    void prepareWatchdog();

    void do_init();
    void do_final() const;

    //
    // Maintenance
    //

    int32 map_cleanup(timer::time_point tick, CTaskManager::CTask* PTask) const; // Clean up timed out players
    int32 map_garbage_collect(timer::time_point tick, CTaskManager::CTask* PTask) const;

    //
    // Commands callbacks
    //

    void onStats(std::vector<std::string>& inputs) const;
    void onBacktrace(std::vector<std::string>& inputs) const;
    void onReloadRecipes(std::vector<std::string>& inputs) const;
    void onGM(const std::vector<std::string>& inputs) const;

    //
    // Accessors
    //

    auto networking() const -> MapNetworking&;
    auto statistics() const -> MapStatistics&;
    auto zones() const -> std::map<uint16, CZone*>&; // g_PZoneList
    // gameState()

private:
    std::unique_ptr<MapStatistics> mapStatistics_;
    std::unique_ptr<MapNetworking> networking_;
    std::unique_ptr<Watchdog>      watchdog_;
    MapConfig&                     engineConfig_;
};
