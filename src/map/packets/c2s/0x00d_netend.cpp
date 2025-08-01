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

#include "0x00d_netend.h"

auto GP_CLI_COMMAND_NETEND::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // Packet explicitly ignored.
    return PacketValidator();
}

void GP_CLI_COMMAND_NETEND::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Do nothing.
}
