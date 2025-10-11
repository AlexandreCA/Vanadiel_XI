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

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x003E
// This packet is sent by the server to inform the client to prepare to open a shop window.
class GP_SERV_COMMAND_SHOP_OPEN final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_SHOP_OPEN, GP_SERV_COMMAND_SHOP_OPEN>
{
public:
    struct PacketData
    {
        uint16_t ShopListNum; // PS2: ShopListNum
        uint16_t padding00;
    };

    GP_SERV_COMMAND_SHOP_OPEN(const CCharEntity* PChar);
};
