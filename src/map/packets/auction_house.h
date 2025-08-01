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

#include "common/cbasetypes.h"

#include "basic.h"
#include "c2s/0x04e_auc.h"

#define AUCTION_ID 4 // Global Auction or AH-Jeuno

class CItem;
class CCharEntity;

class CAuctionHousePacket : public CBasicPacket
{
public:
    CAuctionHousePacket(uint8 action);                                                      // Send the auction menu
    CAuctionHousePacket(GP_CLI_COMMAND_AUC_COMMAND action, uint8 slot, CCharEntity* PChar); // Send the list of items sold by a character
    CAuctionHousePacket(GP_CLI_COMMAND_AUC_COMMAND action, uint8 message, uint16 itemid, uint32 price, uint8 quantity, uint8 stacksize);
    CAuctionHousePacket(GP_CLI_COMMAND_AUC_COMMAND action, uint8 message, CCharEntity* PChar, uint8 slot, bool keepItem);
    CAuctionHousePacket(GP_CLI_COMMAND_AUC_COMMAND action, CItem* PItem, uint8 quantity, uint32 price);
};
