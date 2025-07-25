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

#include "macroequipset.h"

#include "c2s/0x052_equipset_check.h"
#include "item_container.h"
#include "items/item_equipment.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

// This packet is sent to the map server whenever a client is assembling an equip set.
// On retail, it seems to do the following:
// Prevent you from equipping items that shouldn't pair together, such as:
// 2h weapon & shield
// 2h weapon & 1h weapon
// h2h and any sub
// head item while wearing a cloak
// etc
// Later, these sets may be used for /lockstyleset.
// /lockstyleset commands also have their own checking for slots that should never be used together
CAddtoEquipSet::CAddtoEquipSet(const CCharEntity* PChar, const GP_CLI_COMMAND_EQUIPSET_CHECK& data)
{
    this->setType(0x116);
    this->setSize(0x46);

    CItemEquipment* equipSet[16]         = {};
    uint8           equipSetBag[16]      = {};
    uint8           equipSetBagIndex[16] = {};
    bool            equipSetDisabled[16] = {};

    const uint8  equippedIndex       = data.EquipKind;                // Where packet claims the new item is going
    const bool   newItemSlotDisabled = data.ItemChange.RemoveItemFlg; // single bit, indicates this slot is intentionally disabled
    const uint8  newItemBag          = data.ItemChange.Category;      // 6 bits for bag
    const uint8  newItemBagIndex     = data.ItemChange.ItemIndex;     // one byte for bag index
    const uint16 newItemID           = data.ItemChange.ItemNo;        // 2 bytes for item ID

    // Previous set
    for (int i = 0; i < 0x10; i++)
    {
        const bool   slotDisabled = data.Equipment[i].RemoveItemFlg; // single bit, indicates slot intentionally disabled
        const uint8  bag          = data.Equipment[i].Category;      // 6 bits for bag
        const uint8  bagIndex     = data.Equipment[i].ItemIndex;     // one byte for bag index
        const uint16 itemID       = data.Equipment[i].ItemNo;        // 2 bytes for item ID

        // Retail doesn't do strict checking on items already in the set
        // This is probably due to the fact you can move items later
        // The actual equip command should handle erroneous input and/or missing items
        auto* PItem = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(itemID));

        equipSet[i]         = PItem;
        equipSetBag[i]      = bag;
        equipSetBagIndex[i] = bagIndex;
        equipSetDisabled[i] = slotDisabled;
    }

    auto* newItem = dynamic_cast<CItemEquipment*>(PChar->getStorage(newItemBag)->GetItem(newItemBagIndex));
    // check for bad packet
    if (newItem && ((newItem->getEquipSlotId() & (1 << equippedIndex)) == 0 || newItemID != newItem->getID()))
    {
        return;
    }

    if (newItem && !newItemSlotDisabled)
    {
        // Check if we need to remove stuff
        const auto removeSlotID = newItem->getRemoveSlotId();

        for (uint8 i = 0; i < sizeof(removeSlotID) * 8; ++i)
        {
            // Remove things this item should remove
            if (removeSlotID & (1 << i))
            {
                equipSet[i] = nullptr;
            }

            // Check if the existing item conflicts
            if (equipSet[i])
            {
                if (equipSet[i]->getRemoveSlotId() & newItem->getEquipSlotId())
                {
                    equipSet[i] = nullptr;
                }
            }
        }

        const CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(equipSet[SLOT_MAIN]);
        const CItemWeapon* PSub    = dynamic_cast<CItemWeapon*>(equipSet[SLOT_SUB]);
        const CItemWeapon* PRanged = dynamic_cast<CItemWeapon*>(equipSet[SLOT_RANGED]);
        const CItemWeapon* PAmmo   = dynamic_cast<CItemWeapon*>(equipSet[SLOT_AMMO]);

        if (const CItemWeapon* newItemWeapon = dynamic_cast<CItemWeapon*>(newItem))
        {
            // Remove sub for H2H
            if (newItemWeapon->isHandToHand())
            {
                equipSet[SLOT_SUB] = nullptr;
            }

            // Remove one handed weapons or shield from sub if new item is two handed
            if (newItemWeapon->isTwoHanded())
            {
                if ((PSub && PSub->getSkillType() != SKILL_NONE) || (equipSet[SLOT_SUB] && equipSet[SLOT_SUB]->IsShield()))
                {
                    equipSet[SLOT_SUB] = nullptr;
                }
            }

            // Remove non-matching ammo/ranged weapon
            if (newItemWeapon->isRanged())
            {
                if (PAmmo && PAmmo->getSkillType() != newItemWeapon->getSkillType())
                {
                    equipSet[SLOT_AMMO] = nullptr;
                }
                if (PRanged && PRanged->getSkillType() != newItemWeapon->getSkillType())
                {
                    equipSet[SLOT_RANGED] = nullptr;
                }
            }

            // Equipping grip, remove non-2h weapon
            if (newItemWeapon->getSkillType() == SKILL_NONE && newItemWeapon->getEquipSlotId() & 0x02)
            {
                if (PWeapon && !PWeapon->isTwoHanded())
                {
                    equipSet[SLOT_MAIN] = nullptr;
                }
            }

            // Equipping 1h item in main slot with grip in sub
            if (equippedIndex == SLOT_MAIN && !newItemWeapon->isHandToHand() && !newItemWeapon->isTwoHanded())
            {
                if (PSub && PSub->getSkillType() == SKILL_NONE)
                {
                    equipSet[SLOT_SUB] = nullptr;
                }
            }
        }

        // remove two handed weapons in main slot if new item is a shield
        if (newItem->IsShield() && PWeapon && PWeapon->isTwoHanded())
        {
            equipSet[SLOT_MAIN] = nullptr;
        }

        equipSet[equippedIndex]         = newItem;
        equipSetBag[equippedIndex]      = newItemBag;
        equipSetBagIndex[equippedIndex] = newItemBagIndex;
        equipSetDisabled[equippedIndex] = newItemSlotDisabled;
    }
    else
    {
        equipSet[equippedIndex]         = nullptr;
        equipSetDisabled[equippedIndex] = true;
    }

    for (int i = 0; i < 0x10; i++)
    {
        // If the item exists and it can be equipped in that slot
        if (equipSet[i] && equipSet[i]->getEquipSlotId() & (1 << i))
        {
            // set Active, pack in bag index
            ref<uint8>(0x04 + 0x04 * i)  = (1 | (equipSetBag[i] << 2));
            ref<uint8>(0x05 + 0x04 * i)  = equipSetBagIndex[i];
            ref<uint16>(0x06 + 0x04 * i) = equipSet[i]->getID();
        }
        else if (equipSetDisabled[i])
        {
            // set the disabled bit
            ref<uint8>(0x04 + 0x04 * i)  = 0x02;
            ref<uint8>(0x05 + 0x04 * i)  = 0;
            ref<uint16>(0x06 + 0x04 * i) = 0;
        }
    }
}
