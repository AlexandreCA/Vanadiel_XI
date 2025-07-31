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

#include "0x00c_gameok.h"

#include "entities/charentity.h"
#include "packets/char_jobs.h"
#include "packets/inventory_size.h"
#include "packets/jobpoint_details.h"
#include "packets/menu_config.h"
#include "treasure_pool.h"
#include "utils/charutils.h"
#include "utils/petutils.h"

auto GP_CLI_COMMAND_GAMEOK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(ClientState, 0, "ClientState not 0")
        .mustEqual(DebugClientFlg, 0, "DebugClientFlg not 0");
}

void GP_CLI_COMMAND_GAMEOK::process(MapSession* PSession, CCharEntity* PChar) const
{
    PChar->pushPacket<CInventorySizePacket>(PChar);
    PChar->pushPacket<CMenuConfigPacket>(PChar);
    PChar->pushPacket<CCharJobsPacket>(PChar);

    if (charutils::hasKeyItem(PChar, KeyItem::JOB_BREAKER))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket<CJobPointDetailsPacket>(PChar);
    }

    // TODO: While in mog house; treasure pool is not created.
    if (PChar->PTreasurePool != nullptr)
    {
        PChar->PTreasurePool->updatePool(PChar);
    }
    PChar->loc.zone->SpawnTransport(PChar);

    // respawn any pets from last zone
    if (PChar->loc.zone->CanUseMisc(MISC_PET) && !PChar->m_moghouseID)
    {
        if (PChar->shouldPetPersistThroughZoning())
        {
            petutils::SpawnPet(PChar, PChar->petZoningInfo.petID, true);
        }

        PChar->resetPetZoningInfo();
    }
}
