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

class CBaseEntity;
class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00F4
// This packet is sent by the server in response to a clients wide scan request, used to populate a wide scan entry.
class GP_SERV_COMMAND_TRACKING_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TRACKING_LIST, GP_SERV_COMMAND_TRACKING_LIST>
{
public:
    struct PacketData
    {
        uint32_t ActIndex : 16; // PS2: ActIndex
        uint32_t Level : 8;     // PS2: Level
        uint32_t Type : 3;      // PS2: Type
        uint32_t unused : 5;    // PS2: unused
        int16_t  x;             // PS2: x
        int16_t  z;             // PS2: z
        uint8_t  sName[16];     // PS2: sName
    };

    GP_SERV_COMMAND_TRACKING_LIST(const CCharEntity* PChar, CBaseEntity* PEntity);
};
