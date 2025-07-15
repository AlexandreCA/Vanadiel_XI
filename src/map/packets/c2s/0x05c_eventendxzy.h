/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "base.h"

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x005C
// This packet is sent by the client when updating an event that involves the clients position. (ie. Requesting to warp between telepoints.)
GP_CLI_PACKET(GP_CLI_COMMAND_EVENTENDXZY,
              float    x;         // PS2: x
              float    y;         // PS2: y
              float    z;         // PS2: z
              uint32_t UniqueNo;  // PS2: UniqueNo
              uint32_t EndPara;   // PS2: EndPara
              uint16_t EventNum;  // PS2: EventNum
              uint16_t EventPara; // PS2: EventPara
              uint16_t ActIndex;  // PS2: ActIndex
              uint8_t  Mode;      // PS2: Mode
              int8_t   dir;       // PS2: dir
);
