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

#include <cstring>

#include "entities/charentity.h"
#include "shop_items.h"
#include "trade_container.h"

CShopItemsPacket::CShopItemsPacket(CCharEntity* PChar)
{
    this->setType(0x3C);
    this->setSize(0x08);

    uint8 ItemsCount = PChar->Container->getItemsCount();

    uint8 i = 0;
    for (uint8 slotID = 0; slotID < ItemsCount; ++slotID)
    {
        if (i == 20)
        {
            PChar->pushPacket(this->copy());

            i = 0;
            this->setSize(0x08);
            std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 8);
        }
        this->setSize(this->getSize() + 0x0C); // TODO: Verify

        ref<uint32>(i * 12 + 0x08) = PChar->Container->getQuantity(slotID);
        ref<uint16>(i * 12 + 0x0C) = PChar->Container->getItemID(slotID);
        ref<uint8>(i * 12 + 0x0E)  = slotID;
        ref<uint8>(i * 12 + 0x10)  = PChar->Container->getGuildID(slotID);
        ref<uint16>(i * 12 + 0x12) = (PChar->Container->getGuildRank(slotID) + 1) * 100;
        i++;
    }
}
