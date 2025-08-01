﻿/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Team

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

#ifndef _CPETSKILL_H
#define _CPETSKILL_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

class CPetSkill
{
public:
    CPetSkill(uint16 id);

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
    uint16          getMobSkillID() const;
    uint8           getAoe() const;
    float           getDistance() const;
    uint8           getFlag() const;
    timer::duration getAnimationTime() const;
    timer::duration getActivationTime() const;
    uint16          getMsg() const;
    uint8           getSkillFinishCategory() const;
    uint16          getAoEMsg() const;
    uint16          getValidTargets() const;
    int16           getTP() const;
    uint8           getHPP() const;
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
    void setMobSkillID(uint16 skillID);
    void setAoe(uint8 aoe);
    void setDistance(float distance);
    void setFlag(uint8 flag);
    void setAnimationTime(timer::duration AnimationTime);
    void setActivationTime(timer::duration ActivationTime);
    void setMsg(uint16 msg);
    void setSkillFinishCategory(uint8 category);
    void setValidTargets(uint16 targ);
    void setTP(int16 tp);
    void setHPP(uint8 hpp);
    void setTotalTargets(uint16 targets);
    void setPrimaryTargetID(uint32 targid);
    void setParam(int16 value);
    void setKnockback(uint8 knockback);
    void setPrimarySkillchain(uint8 skillchain);
    void setSecondarySkillchain(uint8 skillchain);
    void setTertiarySkillchain(uint8 skillchain);

    const std::string& getName() const;
    void               setName(const std::string& name);

private:
    uint16          m_ID;
    uint16          m_AnimID;     // animation id
    uint16          m_MobSkillID; // mobskill id for jug petskill packet to use instead of JA ability ID
    std::string     m_name;
    uint8           m_Aoe;
    float           m_Distance;
    timer::duration m_AnimationTime;  // how long the tp animation lasts
    timer::duration m_ActivationTime; // how long the pet prepares the tp move for
    uint16          m_ValidTarget;
    uint16          m_Message; // message param, scripters can edit this depending on self/resist/etc.
    uint8           m_Flag;
    int16           m_Param;
    uint8           m_SkillFinishCategory;
    uint8           m_knockback;         // knockback value (0-7)
    uint8           m_primarySkillchain; // weaponskill ID of skillchain properties
    uint8           m_secondarySkillchain;
    uint8           m_tertiarySkillchain;

    int16  m_TP;  // the tp at the time of finish readying (for scripts)
    uint8  m_HPP; // HPP at the time of using mob skill (for scripts)
    uint16 m_TotalTargets;
    uint32 m_PrimaryTargetID; // primary target ID
};

#endif
