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

#ifndef _CMOBSKILL_H
#define _CMOBSKILL_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include <vector>

class CBattleEntity;

enum SKILLFLAG
{
    SKILLFLAG_NONE        = 0x000,
    SKILLFLAG_ASTRAL_FLOW = 0x002, // Player's Avatar Astral Flow blood pacts. TODO: give player pet skills their own separate enum, move avatar stuff there.
    SKILLFLAG_NO_TP_COST  = 0x004, // Don't auto deduct TP
    SKILLFLAG_HIT_ALL     = 0x008, // Strike players even if not in party/alliance
    // unused                = 0x010,
    // unused                = 0x020,
    SKILLFLAG_BLOODPACT_RAGE = 0x040,
    SKILLFLAG_BLOODPACT_WARD = 0x080,
};

enum AOE_TYPE
{
    NONE      = 0,
    ROUND     = 1, // Normal AoE type
    CONE      = 4, // Forward conal AoE
    REAR_CONE = 8, // conal AoE behind the source
};

#define MAX_MOBSKILL_ID 4262

class CMobSkill
{
public:
    CMobSkill(uint16 id);

    bool hasMissMsg() const;
    bool isAoE() const;
    bool isConal() const;
    bool isSingle() const;
    bool isTpFreeSkill() const;
    bool isAstralFlow() const;
    bool isBloodPactWard() const;
    bool isBloodPactRage() const;

    uint16          getID() const;
    uint16          getAnimationID() const;
    uint8           getAoe() const;
    float           getDistance() const;
    uint8           getFlag() const;
    timer::duration getAnimationTime() const;
    timer::duration getActivationTime() const;
    uint16          getMsg() const;
    uint16          getAoEMsg() const;
    uint16          getValidTargets() const;
    int16           getTP() const;
    auto            getHP() const -> int32;
    uint8           getHPP() const;
    auto            getTargets() const -> const std::vector<CBattleEntity*>&;
    uint16          getTotalTargets() const;
    uint32          getPrimaryTargetID() const;
    uint16          getMsgForAction() const;
    float           getRadius() const;
    int16           getParam() const;
    uint8           getKnockback() const;
    uint8           getPrimarySkillchain() const;
    uint8           getSecondarySkillchain() const;
    uint8           getTertiarySkillchain() const;

    bool isDamageMsg() const;

    void setID(uint16 id);
    void setAnimationID(uint16 aid);
    void setAoe(uint8 aoe);
    void setAoeRadius(float aoeRadius);
    void setDistance(float distance);
    void setFlag(uint8 flag);
    void setAnimationTime(timer::duration AnimationTime);
    void setActivationTime(timer::duration ActivationTime);
    void setMsg(uint16 msg);
    void setValidTargets(uint16 targ);
    void setTP(int16 tp);
    auto setHP(int32 hp) -> void;
    void setHPP(uint8 hpp);
    void setTargets(const std::vector<CBattleEntity*>& targets);
    void setTotalTargets(uint16 targets);
    void setPrimaryTargetID(uint32 targid);
    void setParam(int16 value);
    void setKnockback(uint8 knockback);
    void setPrimarySkillchain(uint8 skillchain);
    void setSecondarySkillchain(uint8 skillchain);
    void setTertiarySkillchain(uint8 skillchain);

    const std::string& getName();
    void               setName(const std::string& name);

private:
    uint16          m_ID;
    uint16          m_TotalTargets;
    uint32          m_primaryTargetID; // Primary target ID
    int16           m_Param;
    uint16          m_AnimID;
    uint8           m_Aoe;       // Defines the type of AOE
    float           m_AoeRadius; // Radius of any aoe skill
    float           m_Distance;  // Distance at which the skill will be triggered
    uint8           m_Flag;
    uint16          m_ValidTarget;
    timer::duration m_AnimationTime;  // how long the tp animation lasts for in ms
    timer::duration m_ActivationTime; // how long the mob prepares the tp move for
    uint16          m_Message;        // message param, scripters can edit this depending on self/resist/etc.
    int16           m_TP;             // the tp at the time of finish readying (for scripts)
    int32           m_HP;             // HP at the time of using mob skill (for scripts)
    uint8           m_HPP;            // HPP at the time of using mob skill (for scripts)
    uint8           m_knockback;      // knockback value (0-7)
    uint8           m_primarySkillchain;
    uint8           m_secondarySkillchain;
    uint8           m_tertiarySkillchain;

    std::string m_name;

    std::vector<CBattleEntity*> m_Targets;
};

#endif
