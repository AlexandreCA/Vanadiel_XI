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

#ifndef _CPARTYEFFECTSPACKET_H
#define _CPARTYEFFECTSPACKET_H

#include "common/cbasetypes.h"
#include "entities/charentity.h"

#include "basic.h"

class CBattleEntity;

class CPartyEffectsPacket : public CBasicPacket
{
public:
    explicit CPartyEffectsPacket(const std::vector<CCharEntity*>& membersList);
    void AddMemberEffects(std::size_t partyIndex, CCharEntity* PMember);
    void AddMemberEffects(uint32 id);
};

#endif
