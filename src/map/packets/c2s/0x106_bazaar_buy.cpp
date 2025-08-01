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

#include "0x106_bazaar_buy.h"

#include "common/async.h"
#include "entities/charentity.h"
#include "packets/bazaar_close.h"
#include "packets/bazaar_confirmation.h"
#include "packets/bazaar_item.h"
#include "packets/bazaar_purchase.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

auto GP_CLI_COMMAND_BAZAAR_BUY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // TODO: Short-circuit PV so we can bring all the other checks into this function
    return PacketValidator()
        .range("BuyNum", BuyNum, 1, 99);
}

void GP_CLI_COMMAND_BAZAAR_BUY::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PEntity = PChar->GetEntity(PChar->BazaarID.targid, TYPE_PC);
    if (!PEntity)
    {
        return;
    }

    auto* PTarget = static_cast<CCharEntity*>(PEntity);
    if (PTarget->id != PChar->BazaarID.id)
    {
        return;
    }

    CItemContainer* PBazaar         = PTarget->getStorage(LOC_INVENTORY);
    CItemContainer* PBuyerInventory = PChar->getStorage(LOC_INVENTORY);
    if (PBazaar == nullptr || PBuyerInventory == nullptr)
    {
        return;
    }

    CItem* PBazaarItem = PBazaar->GetItem(BazaarItemIndex);
    if (PBazaarItem == nullptr || PBazaarItem->getReserve() > 0)
    {
        return;
    }

    if (PChar->id == PTarget->id || PBuyerInventory->GetFreeSlotsCount() == 0)
    {
        PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);

        if (settings::get<bool>("logging.DEBUG_BAZAARS") && PChar->id == PTarget->id)
        {
            if (PChar->id == PTarget->id)
            {
                DebugBazaarsFmt("Bazaar Interaction [Purchase Failed / Self Bazaar] - Character: {}, Item: {}", PChar->name, PBazaarItem->getName());
            }
            if (PBuyerInventory->GetFreeSlotsCount() == 0)
            {
                DebugBazaarsFmt("Bazaar Interaction [Purchase Failed / Inventory Full] - Buyer: {}, Seller: {}, Item: {}", PChar->name, PTarget->name, PBazaarItem->getName());
            }
        }

        return;
    }

    // Obtain the players gil
    const CItem* PCharGil = PBuyerInventory->GetItem(0);
    if (PCharGil == nullptr || !PCharGil->isType(ITEM_CURRENCY) || PCharGil->getReserve() > 0)
    {
        // Player has no gil
        PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);
        return;
    }

    if ((PBazaarItem->getCharPrice() != 0) && (PBazaarItem->getQuantity() >= BuyNum))
    {
        const uint32 Price        = (PBazaarItem->getCharPrice() * BuyNum);
        uint32       PriceWithTax = (PChar->loc.zone->GetTax() * Price) / 10000 + Price;

        // Validate this player can afford said item
        if (PCharGil->getQuantity() < PriceWithTax)
        {
            PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);

            // Exploit attempt
            ShowWarningFmt("Bazaar Interaction [Insufficient Gil] - Buyer: {}, Seller: {}, Buyer Gil: {}, Price: {}", PChar->name, PTarget->name, PCharGil->getQuantity(), PriceWithTax);

            return;
        }

        CItem* PItem = itemutils::GetItem(PBazaarItem);

        PItem->setCharPrice(0);
        PItem->setQuantity(BuyNum);
        PItem->setSubType(ITEM_UNLOCKED);

        if (charutils::AddItem(PChar, LOC_INVENTORY, PItem) == ERROR_SLOTID)
        {
            return;
        }

        if (settings::get<bool>("map.AUDIT_PLAYER_BAZAAR"))
        {
            Async::getInstance()->submit(
                [itemID        = PItem->getID(),
                 quantity      = BuyNum,
                 sellerID      = PTarget->id,
                 sellerName    = PTarget->getName(),
                 purchaserID   = PChar->id,
                 purchaserName = PChar->getName(),
                 price         = PriceWithTax,
                 date          = earth_time::timestamp()]
                {
                    const auto query = "INSERT INTO audit_bazaar(itemid, quantity, seller, seller_name, purchaser, purchaser_name, price, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    if (!db::preparedStmt(query, itemID, quantity, sellerID, sellerName, purchaserID, purchaserName, price, date))
                    {
                        ShowErrorFmt("Failed to log bazaar purchase (ItemID: {}, Quantity: {}, Seller: {}, Purchaser: {}, Price: {})", itemID, quantity, sellerName, purchaserName, price);
                    }
                });
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(PriceWithTax));
        charutils::UpdateItem(PTarget, LOC_INVENTORY, 0, Price);

        PChar->pushPacket<CBazaarPurchasePacket>(PTarget, true);

        PTarget->pushPacket<CBazaarConfirmationPacket>(PChar, PItem);

        charutils::UpdateItem(PTarget, LOC_INVENTORY, BazaarItemIndex, -static_cast<int32>(BuyNum));

        PTarget->pushPacket<CInventoryItemPacket>(PBazaar->GetItem(BazaarItemIndex), LOC_INVENTORY, BazaarItemIndex);
        PTarget->pushPacket<CInventoryFinishPacket>();

        DebugBazaarsFmt("Bazaar Interaction [Purchase Successful] - Buyer: {}, Seller: {}, Item: {}, Qty: {}, Cost: {}", PChar->name, PTarget->name, PItem->getName(), BuyNum, PriceWithTax);

        bool BazaarIsEmpty = true;

        for (uint8 BazaarSlotID = 1; BazaarSlotID <= PBazaar->GetSize(); ++BazaarSlotID)
        {
            PItem = PBazaar->GetItem(BazaarSlotID);

            if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
            {
                BazaarIsEmpty = false;
                break;
            }
        }
        for (std::size_t i = 0; i < PTarget->BazaarCustomers.size(); ++i)
        {
            PEntity = PTarget->GetEntity(PTarget->BazaarCustomers[i].targid, TYPE_PC);
            if (!PEntity)
            {
                continue;
            }

            if (auto* PCustomer = static_cast<CCharEntity*>(PEntity); PCustomer->id == PTarget->BazaarCustomers[i].id)
            {
                if (PCustomer->id != PChar->id)
                {
                    PCustomer->pushPacket<CBazaarConfirmationPacket>(PChar, BazaarItemIndex, BuyNum);
                }
                PCustomer->pushPacket<CBazaarItemPacket>(PBazaar->GetItem(BazaarItemIndex), BazaarItemIndex, PChar->loc.zone->GetTax());

                if (BazaarIsEmpty)
                {
                    PCustomer->pushPacket<CBazaarClosePacket>(PTarget);

                    DebugBazaarsFmt("Bazaar Interaction [Bazaar Emptied] - Buyer: {}, Seller: {}", PChar->name, PTarget->name);
                }
            }
        }

        if (BazaarIsEmpty)
        {
            PTarget->updatemask |= UPDATE_HP;
        }

        return;
    }

    PChar->pushPacket<CBazaarPurchasePacket>(PTarget, false);
}
