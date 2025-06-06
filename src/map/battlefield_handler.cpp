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

#include <algorithm>
#include <cstring>

#include "ai/states/death_state.h"

#include "alliance.h"

#include "battlefield.h"
#include "battlefield_handler.h"

#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"

#include "lua/luautils.h"

#include "packets/char_recast.h"
#include "packets/char_skills.h"
#include "packets/message_basic.h"

#include "recast_container.h"
#include "status_effect.h"
#include "status_effect_container.h"

#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include "zone.h"

CBattlefieldHandler::CBattlefieldHandler(CZone* PZone)
: m_PZone(PZone)
, m_MaxBattlefields(luautils::OnBattlefieldHandlerInitialize(PZone))
{
}

void CBattlefieldHandler::HandleBattlefields(timer::time_point tick)
{
    TracyZoneScoped;
    // todo: use raw pointers otherwise might be harming lua
    // dont want this to run again if we removed a battlefield
    for (auto& PBattlefield : m_Battlefields)
    {
        if (!PBattlefield.second->CanCleanup())
        {
            PBattlefield.second->onTick(tick);
        }
    }

    // can't std::remove_if in map so i'll workaround it
    for (auto it = m_Battlefields.begin(); it != m_Battlefields.end();)
    {
        auto* PBattlefield = it->second;
        if (PBattlefield->CanCleanup())
        {
            if (PBattlefield->Cleanup(tick, false))
            {
                it = m_Battlefields.erase(it);
                ShowDebug("[CBattlefieldHandler]HandleBattlefields cleaned up Battlefield %s", PBattlefield->GetName().c_str());
                destroy(PBattlefield);
                continue;
            }
        }

        ++it;
    }

    for (auto iter = m_orphanedPlayers.begin(); iter != m_orphanedPlayers.end();)
    {
        if (tick < (*iter).second)
        {
            ++iter;
            continue;
        }

        auto* PChar = m_PZone->GetCharByID((*iter).first);
        if (PChar)
        {
            luautils::OnBattlefieldKick(PChar);
            PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, EffectNotice::Silent);
            m_PZone->updateCharLevelRestriction(PChar);
        }
        iter = m_orphanedPlayers.erase(iter);
    }
}

uint8 CBattlefieldHandler::LoadBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration)
{
    TracyZoneScoped;
    if (PChar->PBattlefield != nullptr || m_Battlefields.size() >= m_MaxBattlefields)
    {
        return BATTLEFIELD_RETURN_CODE_WAIT;
    }

    for (auto&& battlefield : m_Battlefields)
    {
        if (battlefield.first == registration.area)
        {
            return BATTLEFIELD_RETURN_CODE_INCREMENT_REQUEST;
        }
    }

    if (registration.id == 0xFFFF)
    {
        // made it this far so looks like there's a free battlefield
        return BATTLEFIELD_RETURN_CODE_CUTSCENE;
    }

    auto* PBattlefield = new CBattlefield(registration.id, m_PZone, registration.area, PChar);

    const auto rset = db::preparedStmt("SELECT name, fastestName, fastestTime, fastestPartySize "
                                       "FROM bcnm_records "
                                       "WHERE bcnmId = ?",
                                       registration.id);

    if (!rset || rset->rowsCount() == 0 || !rset->next())
    {
        ShowError("Cannot load battlefield : %u ", registration.id);
        return BATTLEFIELD_RETURN_CODE_REQS_NOT_MET;
    }

    const auto name            = rset->get<std::string>("name");
    const auto recordholder    = rset->get<std::string>("fastestName");
    const auto recordtime      = std::chrono::seconds(rset->get<uint32>("fastestTime"));
    const auto recordPartySize = rset->get<size_t>("fastestPartySize");

    PBattlefield->SetName(name);
    PBattlefield->SetRecord(recordholder, recordtime, recordPartySize);
    PBattlefield->SetTimeLimit(registration.timeLimit);
    PBattlefield->SetLevelCap(registration.levelCap);
    PBattlefield->SetMaxParticipants(registration.maxPlayers);
    PBattlefield->SetRuleMask(registration.rules);
    PBattlefield->m_isMission = registration.isMission;
    PBattlefield->m_showTimer = registration.showTimer;

    m_Battlefields.insert(std::make_pair(PBattlefield->GetArea(), PBattlefield));

    if (!PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD))
    {
        PChar->StatusEffectContainer->AddStatusEffect(
            new CStatusEffect(EFFECT_BATTLEFIELD, EFFECT_BATTLEFIELD, PBattlefield->GetID(), 0s, 0s, PChar->id, PBattlefield->GetArea()), EffectNotice::Silent);
    }

    luautils::OnBattlefieldRegister(PChar, PBattlefield);
    luautils::OnBattlefieldInitialize(PBattlefield);
    PBattlefield->InsertEntity(PChar, true);

    return BATTLEFIELD_RETURN_CODE_CUTSCENE;
}

CBattlefield* CBattlefieldHandler::GetBattlefield(CBaseEntity* PEntity, bool checkRegistered)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);

    if (checkRegistered && entity && entity->objtype == TYPE_PC)
    {
        for (auto& battlefield : m_Battlefields)
        {
            if (battlefield.second->IsRegistered(static_cast<CCharEntity*>(entity)))
            {
                return battlefield.second;
            }
        }
        return nullptr;
    }

    for (auto& battlefield : m_Battlefields)
    {
        if (battlefield.second->GetEntity(entity))
        {
            return battlefield.second;
        }
    }
    return nullptr;
}

CBattlefield* CBattlefieldHandler::GetBattlefieldByArea(uint8 area) const
{
    const auto it = m_Battlefields.find(area);
    return it != m_Battlefields.end() ? it->second : nullptr;
}

CBattlefield* CBattlefieldHandler::GetBattlefieldByInitiator(uint32 charID)
{
    for (auto& battlefield : m_Battlefields)
    {
        if (battlefield.second->GetInitiator().id == charID)
        {
            return battlefield.second;
        }
    }
    return nullptr;
}

uint8 CBattlefieldHandler::RegisterBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration)
{
    if (PChar->PBattlefield)
    {
        ShowDebug("%s tried to enter another battlefield", PChar->getName());
        return BATTLEFIELD_RETURN_CODE_WAIT;
    }
    // attempt to add to an existing battlefield
    auto* PBattlefield = GetBattlefield(PChar, true);

    // Could not find this character registered, try find by id and initiator
    if (!PBattlefield)
    {
        for (const auto& battlefield : m_Battlefields)
        {
            if (battlefield.second->GetInitiator().id == registration.initiator && battlefield.second->GetID() == registration.id)
            {
                PBattlefield = battlefield.second;
                break;
            }
        }
        // If the player has no Registered Battlefield...
        if (!PBattlefield)
        {
            // ...but they do have the BCNM Status Effect somehow (This should not happen, but keeping to be safe)
            if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
            {
                // Do not allow them to attain a new registration
                return BATTLEFIELD_RETURN_CODE_REQS_NOT_MET;
            }
            // ...but they did have the flag to enter an existing one
            if (PChar->GetLocalVar("[BCNM]EnterExisting") == 1)
            {
                // Reset the flag, and do not allow them to attain a new registration
                PChar->SetLocalVar("[BCNM]EnterExisting", 0);
                return BATTLEFIELD_RETURN_CODE_REQS_NOT_MET;
            }
        }
    }
    // If they have a Registered Battlefield -AND- they have the Battlefield Status Effect
    if (PBattlefield && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
    {
        // Reset their progress var to 0 and proceed to attempt to enter them into the BCNM
        PChar->SetLocalVar("[BCNM]EnterExisting", 0);
        if (!PBattlefield->CheckInProgress())
        {
            // players haven't started fighting yet, try entering
            if (registration.area != PBattlefield->GetArea())
            {
                return BATTLEFIELD_RETURN_CODE_INCREMENT_REQUEST;
            }

            return PBattlefield->InsertEntity(PChar, false) ? BATTLEFIELD_RETURN_CODE_CUTSCENE : BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL;
        }
        else
        {
            // todo: probably clear registered chars
            // can't enter, mobs been slapped
            return BATTLEFIELD_RETURN_CODE_LOCKED;
        }
    }
    return LoadBattlefield(PChar, registration);
}

bool CBattlefieldHandler::RemoveFromBattlefield(CBaseEntity* PEntity, CBattlefield* PBattlefield, uint8 leavecode)
{
    PBattlefield = PBattlefield ? PBattlefield : GetBattlefield(PEntity);
    return PBattlefield ? PBattlefield->RemoveEntity(PEntity, leavecode) : false;
}

bool CBattlefieldHandler::IsRegistered(CCharEntity* PChar)
{
    for (const auto& battlefield : m_Battlefields)
    {
        if (battlefield.second->IsRegistered(PChar))
        {
            return true;
        }
    }
    return false;
}

bool CBattlefieldHandler::ReachedMaxCapacity(int battlefieldId) const
{
    // area all areas full
    if (m_Battlefields.size() >= (size_t)m_MaxBattlefields)
    {
        return true;
    }

    // NOTE: If allowedAreas is used for a BCNM, this check will return true, but instead
    // the player will be rejected from the instance in the 32000 event update.  This is intentional
    // at this time.

    // we have a free battlefield
    return false;
}

uint8 CBattlefieldHandler::MaxBattlefieldAreas() const
{
    return m_MaxBattlefields;
}

void CBattlefieldHandler::addOrphanedPlayer(CCharEntity* PChar)
{
    auto orphan = std::make_pair(PChar->id, timer::now() + 5s);
    m_orphanedPlayers.emplace_back(orphan);
}
