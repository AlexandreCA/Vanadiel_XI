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

#ifndef _CAddtoEquipSet_H
#define _CAddtoEquipSet_H

#include "basic.h"
#include "common/cbasetypes.h"

struct GP_CLI_COMMAND_EQUIPSET_CHECK;
class CCharEntity;

class CAddtoEquipSet : public CBasicPacket
{
public:
    CAddtoEquipSet(const CCharEntity* PChar, const GP_CLI_COMMAND_EQUIPSET_CHECK& data);
};

#endif
