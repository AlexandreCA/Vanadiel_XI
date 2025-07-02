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

#include "0x0e8_command_camp.h"

#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "status_effect_container.h"

auto GP_CLI_COMMAND_CAMP::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .hasNormalStatus(PChar)
        .isNotPreventedAction(PChar)
        .range("Mode", Mode, GP_CLI_COMMAND_CAMP_MODE::Toggle, GP_CLI_COMMAND_CAMP_MODE::Off)
        .mustNotEqual(
            PChar->animation == ANIMATION_HEALING &&
                Mode == static_cast<uint32_t>(GP_CLI_COMMAND_CAMP_MODE::On),
            true, "Requested healing when already healing")
        .mustNotEqual(
            PChar->animation != ANIMATION_HEALING &&
                Mode == static_cast<uint32_t>(GP_CLI_COMMAND_CAMP_MODE::Off),
            true, "Requested stop healing when not healing");
}

void GP_CLI_COMMAND_CAMP::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto enableHealing = [&]()
    {
        if (PChar->PPet == nullptr ||
            (PChar->PPet->m_EcoSystem != ECOSYSTEM::AVATAR && PChar->PPet->m_EcoSystem != ECOSYSTEM::ELEMENTAL && !PChar->PAI->IsEngaged()))
        {
            PChar->PAI->ClearStateStack();
            if (PChar->PPet && PChar->PPet->objtype == TYPE_PET && static_cast<CPetEntity*>(PChar->PPet)->getPetType() == PET_TYPE::AUTOMATON)
            {
                PChar->PPet->PAI->Disengage();
            }

            PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, std::chrono::seconds(settings::get<uint8>("map.HEALING_TICK_DELAY")), 0s));
            return;
        }

        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 345);
    };

    auto disableHealing = [&]()
    {
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
    };

    // Note: The status effect lua takes care of changing the animation.
    switch (static_cast<GP_CLI_COMMAND_CAMP_MODE>(Mode))
    {
        case GP_CLI_COMMAND_CAMP_MODE::Toggle:
            if (PChar->animation == ANIMATION_HEALING)
            {
                disableHealing();
            }
            else
            {
                enableHealing();
            }
            break;
        case GP_CLI_COMMAND_CAMP_MODE::On:
            enableHealing();
            break;
        case GP_CLI_COMMAND_CAMP_MODE::Off:
            disableHealing();
            break;
    }
}
