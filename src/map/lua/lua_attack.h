/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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
#include "luautils.h"

class CAttack;

class CLuaAttack
{
    CAttack* m_PLuaAttack;

public:
    CLuaAttack(CAttack*);

    CAttack* GetAttack() const
    {
        return m_PLuaAttack;
    }

    bool isCritical() const;
    void setCritical(bool critical);

    friend std::ostream& operator<<(std::ostream& out, const CLuaAttack& action);

    bool operator==(const CLuaAttack& other) const
    {
        return this->m_PLuaAttack == other.m_PLuaAttack;
    }

    static void Register();
};
