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

#include "menu_raisetractor.h"
#include "entities/charentity.h"

CRaiseTractorMenuPacket::CRaiseTractorMenuPacket(CCharEntity* PChar, REVIVAL_TYPE type)
{
    this->setType(0xF9);
    this->setSize(0x0C);

    ref<uint32>(0x04) = PChar->id;
    ref<uint16>(0x08) = PChar->targid;

    ref<uint8>(0x0A) = type;
}
