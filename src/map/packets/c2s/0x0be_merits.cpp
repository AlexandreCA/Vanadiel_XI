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

#include "0x0be_merits.h"

#include "entities/charentity.h"
#include "packets/char_abilities.h"
#include "packets/char_job_extra.h"
#include "packets/char_recast.h"
#include "packets/char_skills.h"
#include "packets/char_stats.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/menu_merit.h"
#include "packets/merit_points_categories.h"
#include "packets/message_basic.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_MERITS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_MERITS_KIND>(Kind)
        .oneOf<GP_CLI_COMMAND_MERITS_PARAM1>(Param1);
}

void GP_CLI_COMMAND_MERITS::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (static_cast<GP_CLI_COMMAND_MERITS_KIND>(Kind))
    {
        case GP_CLI_COMMAND_MERITS_KIND::ChangeMode:
        {
            // Note: While the client restricts the ability to change mode during besieged and when level restricted
            //     : Retail server will still honor an injected request and change the mode.
            if (db::preparedStmt("UPDATE char_exp SET mode = ? WHERE charid = ? LIMIT 1", Param1, PChar->id))
            {
                PChar->MeritMode = Param1;
                PChar->pushPacket<CMenuMeritPacket>(PChar);
                PChar->pushPacket<CMonipulatorPacket1>(PChar);
                PChar->pushPacket<CMonipulatorPacket2>(PChar);
            }
        }
        break;

        case GP_CLI_COMMAND_MERITS_KIND::EditMode:
        {
            if (PChar->m_moghouseID) // Note: This has been verified as allowed in a shared mog house.
            {
                if (const auto merit = static_cast<MERIT_TYPE>(Param2 << 1); PChar->PMeritPoints->IsMeritExist(merit))
                {
                    const Merit_t* PMerit = PChar->PMeritPoints->GetMerit(merit);

                    switch (static_cast<GP_CLI_COMMAND_MERITS_PARAM1>(Param1))
                    {
                        case GP_CLI_COMMAND_MERITS_PARAM1::Lower:
                            PChar->PMeritPoints->LowerMerit(merit);
                            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, Param2, PMerit->count, MSGBASIC_MERIT_DECREASE);
                            break;
                        case GP_CLI_COMMAND_MERITS_PARAM1::Raise:
                            PChar->PMeritPoints->RaiseMerit(merit);
                            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, Param2, PMerit->count, MSGBASIC_MERIT_INCREASE);
                            break;
                    }

                    PChar->pushPacket<CMenuMeritPacket>(PChar);
                    PChar->pushPacket<CMonipulatorPacket1>(PChar);
                    PChar->pushPacket<CMonipulatorPacket2>(PChar);
                    PChar->pushPacket<CMeritPointsCategoriesPacket>(PChar, merit);

                    charutils::SaveCharExp(PChar, PChar->GetMJob());
                    PChar->PMeritPoints->SaveMeritPoints(PChar->id);

                    charutils::BuildingCharSkillsTable(PChar);
                    charutils::CalculateStats(PChar);
                    charutils::CheckValidEquipment(PChar);
                    charutils::BuildingCharAbilityTable(PChar);
                    charutils::BuildingCharTraitsTable(PChar);

                    PChar->UpdateHealth();
                    PChar->addHP(PChar->GetMaxHP());
                    PChar->addMP(PChar->GetMaxMP());
                    PChar->pushPacket<CCharStatusPacket>(PChar);
                    PChar->pushPacket<CCharStatsPacket>(PChar);
                    PChar->pushPacket<CCharSkillsPacket>(PChar);
                    PChar->pushPacket<CCharRecastPacket>(PChar);
                    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
                    PChar->pushPacket<CCharSyncPacket>(PChar);
                }
            }
        }
        break;
    }
}
