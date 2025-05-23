/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#pragma once

#include "common/cbasetypes.h"
#include "common/mmo.h"

class CBattleEntity;
class CCharEntity;
class CTrustEntity;

namespace trustutils
{
    // We cache all of this so we don't have to hit the database every time a trust is spawned
    void LoadTrustList();
    auto SpawnTrust(CCharEntity* PMaster, uint32 TrustID) -> CTrustEntity*;
}; // namespace trustutils
