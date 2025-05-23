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

#include "ability.h"

#include "common/database.h"
#include "common/sql.h"

#include "lua/luautils.h"

#include <map>

CAbility::CAbility(uint16 id)
: m_ID(id)
, m_Job(JOB_NON)
, m_level(0)
, m_animationID(0)
, m_range(0)
, m_aoe(0)
, m_validTarget(0)
, m_addType(0)
, m_message(0)
, m_recastTime(0s)
, m_recastId(0)
, m_CE(0)
, m_VE(0)
, m_meritModID(0)
, m_mobskillId(0)
{
}

bool CAbility::isPetAbility() const
{
    return ((getID() >= ABILITY_CONCENTRIC_PULSE && getID() <= ABILITY_RADIAL_ARCANA) || getID() >= ABILITY_HEALING_RUBY);
}

bool CAbility::isAoE() const
{
    return m_aoe == 1;
}

bool CAbility::isConal()
{
    // no abilities are conal?
    return false;
}

void CAbility::setID(uint16 id)
{
    m_ID = id;
}

void CAbility::setMobSkillID(uint16 id)
{
    m_mobskillId = id;
}

uint16 CAbility::getID() const
{
    return m_ID;
}

uint16 CAbility::getMobSkillID() const
{
    return m_mobskillId;
}

void CAbility::setJob(JOBTYPE Job)
{
    m_Job = Job;
}

void CAbility::setMeritModID(uint16 value)
{
    m_meritModID = value;
}

void CAbility::setActionType(ACTIONTYPE type)
{
    m_actionType = type;
}

void CAbility::setPostActionEffectCleanup(EFFECT effectToCleanup)
{
    m_cleanupEffect = effectToCleanup;
}

JOBTYPE CAbility::getJob()
{
    return m_Job;
}

void CAbility::setLevel(uint8 level)
{
    m_level = level;
}

uint8 CAbility::getLevel() const
{
    return m_level;
}

void CAbility::setRange(float range)
{
    m_range = range;
}

float CAbility::getRange() const
{
    return m_range;
}

void CAbility::setAOE(uint8 aoe)
{
    m_aoe = aoe;
}

uint8 CAbility::getAOE() const
{
    return m_aoe;
}

void CAbility::setAnimationID(uint16 animationID)
{
    m_animationID = animationID;
}

void CAbility::setAnimationTime(timer::duration time)
{
    m_animationTime = time;
}

void CAbility::setCastTime(timer::duration time)
{
    m_castTime = time;
}

uint16 CAbility::getAnimationID() const
{
    return m_animationID;
}

timer::duration CAbility::getAnimationTime()
{
    return m_animationTime;
}

timer::duration CAbility::getCastTime()
{
    return m_castTime;
}

void CAbility::setRecastTime(timer::duration recastTime)
{
    m_recastTime = std::chrono::floor<std::chrono::milliseconds>(recastTime * settings::get<float>("map.ABILITY_RECAST_MULTIPLIER"));
}

timer::duration CAbility::getRecastTime() const
{
    return m_recastTime;
}

uint16 CAbility::getMeritModID() const
{
    return m_meritModID;
}

ACTIONTYPE CAbility::getActionType()
{
    return m_actionType;
}

EFFECT CAbility::getPostActionEffectCleanup()
{
    return m_cleanupEffect;
}

void CAbility::setValidTarget(uint16 validTarget)
{
    m_validTarget = validTarget;
}

uint16 CAbility::getValidTarget() const
{
    return m_validTarget;
}

uint16 CAbility::getAddType() const
{
    return m_addType;
}

void CAbility::setAddType(uint16 addType)
{
    m_addType = addType;
}

const std::string& CAbility::getName()
{
    return m_name;
}

void CAbility::setName(const std::string& name)
{
    m_name = name;
}

uint16 CAbility::getRecastId() const
{
    return m_recastId;
}

void CAbility::setRecastId(uint16 recastId)
{
    m_recastId = recastId;
}

void CAbility::setCE(int32 CE)
{
    m_CE = CE;
}

int32 CAbility::getCE() const
{
    return m_CE;
}

void CAbility::setVE(int32 VE)
{
    m_VE = VE;
}

int32 CAbility::getVE() const
{
    return m_VE;
}

/************************************************************************
 *                                                                       *
 *  Get/Set message abilities                                            *
 *                                                                       *
 ************************************************************************/

uint16 CAbility::getMessage() const
{
    return m_message;
}

void CAbility::setMessage(uint16 message)
{
    m_message = message;
}

uint16 CAbility::getAoEMsg() const
{
    switch (m_message)
    {
        case 150: // Ancient Circle
            return m_message + 1;
        case 185:
            return 264;
        case 186:
            return 266;
        case 187:
            return 281;
        case 188:
            return 282;
        case 189:
            return 283;
        case 225:
            return 366;
        case 226:
            return 226; // no message for this... I guess there is no aoe TP drain move
        case 103:       // recover hp
        case 102:       // recover hp
        case 238:       // recover hp
        case 306:       // recover hp
        case 318:       // recover hp
            return 24;
        case 242:
            return 277;
        case 243:
            return 278;
        case 284:
            return 284; // already the aoe message
        case 370:
            return 404;
        case 362:
            return 363;
        case 378:
            return 343;
        case 224: // recovers mp
            return 276;
        case 420:
        case 424:
            return 421;
        case 422:
        case 425:
            return 423;
        case 426:
            return 427;
        case 435:
        case 437:
        case 439:
            return m_message + 1;
        case 668: // Valiance has a seperate message for party member who gain the effect.
            return m_message + 1;

        default:
            return m_message;
    }
}

/************************************************************************
 *                                                                       *
 *  Namespace implementation for working with abilities                  *
 *                                                                       *
 ************************************************************************/

namespace ability
{
    std::map<uint16, std::unique_ptr<CAbility>> PAbilityList;    // Complete Abilities List
    std::map<JOBTYPE, std::vector<CAbility*>>   PAbilitiesByJob; // Abilities by Job
    std::vector<std::unique_ptr<Charge_t>>      PChargesList;    // Abilities with charges

    /************************************************************************
     *                                                                       *
     *  Load Abilities from Database                                         *
     *                                                                       *
     ************************************************************************/

    void LoadAbilitiesList()
    {
        // TODO: Add message field to table

        const auto rset = db::preparedStmt("SELECT "
                                           "abilityId, "
                                           "IFNULL(min_id, 0) AS mobskillId, "
                                           "name, "
                                           "job, "
                                           "level, "
                                           "validTarget, "
                                           "recastTime, "
                                           "message1, "
                                           "message2, "
                                           "animation, "
                                           "animationTime, "
                                           "castTime, "
                                           "actionType, "
                                           "`range`, "
                                           "isAOE, "
                                           "recastId, "
                                           "CE, "
                                           "VE, "
                                           "meritModID, "
                                           "addType, "
                                           "content_tag "
                                           "FROM abilities LEFT JOIN (SELECT mob_skill_name, MIN(mob_skill_id) AS min_id "
                                           "FROM mob_skills GROUP BY mob_skill_name) mob_skills_1 ON "
                                           "abilities.name = mob_skills_1.mob_skill_name "
                                           "WHERE job < ? AND abilityId < ? "
                                           "ORDER BY job, level ASC",
                                           MAX_JOBTYPE, MAX_ABILITY_ID);

        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                const auto contentTag = rset->getOrDefault<std::string>("content_tag", "");
                if (!luautils::IsContentEnabled(contentTag))
                {
                    continue;
                }

                const auto abilityId    = rset->get<uint16>("abilityId");
                PAbilityList[abilityId] = std::make_unique<CAbility>(abilityId);
                const auto& PAbility    = PAbilityList[abilityId];

                PAbility->setMobSkillID(rset->get<uint16>("mobskillId"));
                PAbility->setName(rset->get<std::string>("name"));
                PAbility->setJob(static_cast<JOBTYPE>(rset->get<uint8>("job")));
                PAbility->setLevel(rset->get<uint8>("level"));
                PAbility->setValidTarget(rset->get<uint16>("validTarget"));
                PAbility->setRecastTime(std::chrono::seconds(rset->get<uint16>("recastTime")));
                PAbility->setMessage(rset->get<uint16>("message1"));
                // Unused - message2
                PAbility->setAnimationID(rset->get<uint16>("animation"));
                PAbility->setAnimationTime(std::chrono::milliseconds(rset->get<uint16>("animationTime")));
                PAbility->setCastTime(std::chrono::milliseconds(rset->get<uint16>("castTime")));
                PAbility->setActionType(static_cast<ACTIONTYPE>(rset->get<uint8>("actionType")));
                PAbility->setRange(rset->get<float>("range"));
                PAbility->setAOE(rset->get<uint8>("isAOE"));
                PAbility->setRecastId(rset->get<uint16>("recastId"));
                PAbility->setCE(rset->get<int32>("CE"));
                PAbility->setVE(rset->get<int32>("VE"));
                PAbility->setMeritModID(rset->get<uint16>("meritModID"));
                PAbility->setAddType(rset->get<uint16>("addType"));

                PAbilitiesByJob[PAbility->getJob()].emplace_back(PAbility.get());

                auto filename = fmt::format("./scripts/actions/abilities/{}.lua", PAbility->getName());
                if (PAbility->isPetAbility())
                {
                    filename = fmt::format("./scripts/actions/abilities/pets/{}.lua", PAbility->getName());
                }
                luautils::CacheLuaObjectFromFile(filename);
            }
        }

        const auto rset2 = db::preparedStmt("SELECT recastId, job, level, maxCharges, chargeTime, meritModId FROM abilities_charges ORDER BY job, level ASC");
        if (rset2 && rset2->rowsCount())
        {
            while (rset2->next())
            {
                auto PCharge        = std::make_unique<Charge_t>();
                PCharge->ID         = rset2->get<uint16>("recastId");
                PCharge->job        = static_cast<JOBTYPE>(rset2->get<uint8>("job"));
                PCharge->level      = rset2->get<uint8>("level");
                PCharge->maxCharges = rset2->get<uint8>("maxCharges");
                PCharge->chargeTime = std::chrono::seconds(rset2->get<uint32>("chargeTime"));
                PCharge->merit      = rset2->get<uint16>("meritModId");

                PChargesList.emplace_back(std::move(PCharge));
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Get Ability By ID                                                    *
     *                                                                       *
     ************************************************************************/

    CAbility* GetAbility(uint16 AbilityID)
    {
        if (auto itr = PAbilityList.find(AbilityID); itr != PAbilityList.end())
        {
            return itr->second.get();
        }
        ShowDebug("Unable to look up ability %d", AbilityID);
        return nullptr;
    }

    /************************************************************************
     *                                                                       *
     *  Get the initial (SP) ability of a job                                *
     *                                                                       *
     ************************************************************************/

    CAbility* GetTwoHourAbility(JOBTYPE JobID)
    {
        if (JobID >= JOB_WAR || JobID <= MAX_JOBTYPE)
        {
            switch (JobID)
            {
                case JOB_WAR:
                    return GetAbility(ABILITY_MIGHTY_STRIKES);
                    break;
                case JOB_MNK:
                    return GetAbility(ABILITY_HUNDRED_FISTS);
                    break;
                case JOB_WHM:
                    return GetAbility(ABILITY_BENEDICTION);
                    break;
                case JOB_BLM:
                    return GetAbility(ABILITY_MANAFONT);
                    break;
                case JOB_RDM:
                    return GetAbility(ABILITY_CHAINSPELL);
                    break;
                case JOB_THF:
                    return GetAbility(ABILITY_PERFECT_DODGE);
                    break;
                case JOB_PLD:
                    return GetAbility(ABILITY_INVINCIBLE);
                    break;
                case JOB_DRK:
                    return GetAbility(ABILITY_BLOOD_WEAPON);
                    break;
                case JOB_BST:
                    return GetAbility(ABILITY_FAMILIAR);
                    break;
                case JOB_BRD:
                    return GetAbility(ABILITY_SOUL_VOICE);
                    break;
                case JOB_RNG:
                    return GetAbility(ABILITY_EAGLE_EYE_SHOT);
                    break;
                case JOB_SAM:
                    return GetAbility(ABILITY_MEIKYO_SHISUI);
                    break;
                case JOB_NIN:
                    return GetAbility(ABILITY_MIJIN_GAKURE);
                    break;
                case JOB_DRG:
                    return GetAbility(ABILITY_SPIRIT_SURGE);
                    break;
                case JOB_SMN:
                    return GetAbility(ABILITY_ASTRAL_FLOW);
                    break;
                case JOB_BLU:
                    return GetAbility(ABILITY_AZURE_LORE);
                    break;
                case JOB_COR:
                    return GetAbility(ABILITY_WILD_CARD);
                    break;
                case JOB_PUP:
                    return GetAbility(ABILITY_OVERDRIVE);
                    break;
                case JOB_DNC:
                    return GetAbility(ABILITY_TRANCE);
                    break;
                case JOB_SCH:
                    return GetAbility(ABILITY_TABULA_RASA);
                    break;
                case JOB_GEO:
                    return GetAbility(ABILITY_BOLSTER);
                    break;
                case JOB_RUN:
                    return GetAbility(ABILITY_ELEMENTAL_SFORZO);
                    break;
                default:
                    break;
            }
        }

        ShowWarning("Attempt to get two hour ability with invalid JOBTYPE %d.", JobID);
        return nullptr;
    }

    bool CanLearnAbility(CBattleEntity* PUser, uint16 AbilityID)
    {
        auto* PAbility = GetAbility(AbilityID);
        if (PAbility)
        {
            uint8 Job    = PAbility->getJob();
            uint8 JobLvl = PAbility->getLevel();

            return ((PUser->GetMJob() == Job && PUser->GetMLevel() >= JobLvl) || (PUser->GetSJob() == Job && PUser->GetSLevel() >= JobLvl));
        }
        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Get Abilities By JobID                                               *
     *                                                                       *
     ************************************************************************/

    std::vector<CAbility*> GetAbilities(JOBTYPE JobID)
    {
        return PAbilitiesByJob[JobID];
    }

    Charge_t* GetCharge(CBattleEntity* PUser, uint16 chargeID)
    {
        Charge_t* charge = nullptr;
        for (auto& PCharge : PChargesList)
        {
            if (PCharge->ID == chargeID)
            {
                if (PUser->GetMJob() == PCharge->job)
                {
                    if (PUser->GetMLevel() >= PCharge->level)
                    {
                        charge = PCharge.get();
                    }
                    else
                    {
                        break;
                    }
                }
                else if (PUser->GetSJob() == PCharge->job)
                {
                    if (PUser->GetSLevel() >= PCharge->level)
                    {
                        charge = PCharge.get();
                    }
                    else
                    {
                        break;
                    }
                }
            }
        }
        return charge;
    }

    uint32 GetAbsorbMessage(uint32 msg)
    {
        if (msg == 110)
        {
            return 102;
        }
        else if (msg == 264)
        {
            return 263;
        }
        return msg;
    }
}; // namespace ability
