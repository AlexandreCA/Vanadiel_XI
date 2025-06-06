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

#ifndef _MOB_CONTROLLER_H
#define _MOB_CONTROLLER_H

#include "controller.h"
#include "entities/mobentity.h"

enum class FollowType : uint8
{
    None,
    Roam,
    RunAway,
};

class CMobController : public CController
{
public:
    CMobController(CMobEntity* PMob);

    virtual void Tick(timer::time_point tick) override;
    virtual bool Disengage() override;
    virtual bool Engage(uint16 targid) override;
    virtual void Despawn() override;
    virtual void Reset() override;

    virtual bool MobSkill(uint16 targid, uint16 wsid);
    virtual bool Ability(uint16 targid, uint16 abilityid) override
    {
        return false;
    }
    bool MobSkill(int list = 0);
    bool TryCastSpell();
    bool TrySpecialSkill();

    bool         CanFollowTarget(CBattleEntity*);
    bool         CanAggroTarget(CBattleEntity*);
    void         TapDeaggroTime();
    void         TapDeclaimTime();
    virtual bool Cast(uint16 targid, SpellID spellid) override;
    void         SetFollowTarget(CBaseEntity* PTarget, FollowType followType);
    bool         HasFollowTarget();
    void         ClearFollowTarget();
    bool         CheckHide(CBattleEntity* PTarget);

    void OnCastStopped(CMagicState& state, action_t& action);

protected:
    virtual bool TryDeaggro();

    virtual void TryLink();
    bool         CanDetectTarget(CBattleEntity* PTarget, bool forceSight = false);
    bool         CanPursueTarget(CBattleEntity* PTarget);
    bool         CheckLock(CBattleEntity* PTarget);
    bool         CheckDetection(CBattleEntity* PTarget);
    virtual bool CanCastSpells();
    void         CastSpell(SpellID spellid);
    virtual void Move();

    virtual void DoCombatTick(timer::time_point tick);
    void         FaceTarget(uint16 targid = 0);
    virtual void HandleEnmity();

    virtual void DoRoamTick(timer::time_point tick);
    void         Wait(timer::duration _duration);
    void         FollowRoamPath();
    bool         CanMoveForward(float currentDistance);
    bool         IsSpecialSkillReady(float currentDistance);
    bool         IsSpellReady(float currentDistance);

    CBattleEntity* PTarget{ nullptr };

    static constexpr float FollowRoamDistance{ 4.0f };
    static constexpr float FollowRunAwayDistance{ 4.0f };
    CBaseEntity*           PFollowTarget{ nullptr };

private:
    CMobEntity* const PMob;

    timer::time_point m_LastActionTime;
    timer::time_point m_nextMagicTime;
    timer::time_point m_LastMobSkillTime;
    timer::time_point m_LastSpecialTime;
    timer::time_point m_DeaggroTime;
    timer::time_point m_DeclaimTime;
    timer::time_point m_NeutralTime;
    timer::time_point m_WaitTime;
    timer::time_point m_mobHealTime;
    FollowType        m_followType = FollowType::None;

    bool              m_firstSpell{ true };
    timer::time_point m_LastRoamScript{ timer::time_point::min() };
};

#endif // _AI_CONTROLLER_H
