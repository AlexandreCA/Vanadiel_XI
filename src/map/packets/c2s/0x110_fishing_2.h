/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "base.h"

enum class GP_CLI_COMMAND_FISHING_2_MODE : uint8_t
{
    RequestCheckHook        = 2,
    RequestEndMiniGame      = 3,
    RequestRelease          = 4,
    RequestPotentialTimeout = 5,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0110
// This packet is sent by the client when interacting with the fishing mini-game system.
// Note: 0x066 handles the old fishing system, while 0x110 handles the new fishing mini-game.
GP_CLI_PACKET(GP_CLI_COMMAND_FISHING_2,
              uint32_t UniqueNo;  // The local clients server id.
              int32_t  para;      // The fishing parameter.
              uint16_t ActIndex;  // The local clients target index.
              int8_t   mode;      // The fishing mode.
              uint8_t  padding00; // Padding; unused.
              int32_t  para2;     // The fishing parameter (2).
);