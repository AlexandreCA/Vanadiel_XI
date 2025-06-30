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

#include "0x0ff_myroom_plant_stop.h"

#include "entities/charentity.h"
#include "items/item_flowerpot.h"
#include "packets/char_status.h"
#include "packets/furniture_interact.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "utils/charutils.h"

namespace
{
    const std::vector<uint8_t> validPlantCategories = { LOC_MOGSAFE, LOC_MOGSAFE2 };
}

auto GP_CLI_COMMAND_MYROOM_PLANT_STOP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(MyroomPlantItemNo, 0, "MyroomPlantItemNo must not be 0")
        .oneOf("MyroomPlantCategory", MyroomPlantCategory, validPlantCategories);
}

void GP_CLI_COMMAND_MYROOM_PLANT_STOP::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer* PItemContainer = PChar->getStorage(MyroomPlantCategory);
    CItemFlowerpot* PItem          = static_cast<CItemFlowerpot*>(PItemContainer->GetItem(MyroomPlantItemIndex));

    if (PItem != nullptr && PItem->isPlanted() && PItem->getStage() > FLOWERPOT_STAGE_INITIAL && PItem->getStage() < FLOWERPOT_STAGE_WILTED && !PItem->isDried())
    {
        PChar->pushPacket<CMessageStandardPacket>(MyroomPlantItemNo, MsgStd::MoogleDriesPlant);
        PChar->pushPacket<CFurnitureInteractPacket>(PItem, MyroomPlantCategory, MyroomPlantItemIndex);
        PItem->setDried(true);

        db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                         PItem->m_extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        PChar->pushPacket<CInventoryItemPacket>(PItem, MyroomPlantCategory, MyroomPlantItemIndex);
        PChar->pushPacket<CInventoryFinishPacket>();
    }
}
