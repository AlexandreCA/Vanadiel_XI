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

#ifndef _CINACTIVE_STATE_H
#define _CINACTIVE_STATE_H

#include "state.h"

class CInactiveState : public CState
{
public:
    CInactiveState(CBaseEntity* PEntity, timer::duration _duration, bool canChangeState, bool untargetable);

    bool GetUntargetable()
    {
        return m_untargetable;
    }

protected:
    virtual bool CanChangeState() override
    {
        return m_canChangeState;
    }
    virtual bool CanFollowPath() override
    {
        return false;
    }
    virtual bool CanInterrupt() override
    {
        return false;
    }

    virtual bool Update(timer::time_point tick) override;
    virtual void Cleanup(timer::time_point tick) override;

private:
    timer::duration m_duration;
    bool            m_canChangeState{ false };
    bool            m_untargetable{ false };
};

#endif
