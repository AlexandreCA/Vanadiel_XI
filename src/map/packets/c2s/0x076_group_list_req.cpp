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

#include "0x076_group_list_req.h"

#include "entities/charentity.h"
#include "packets/party_define.h"

auto GP_CLI_COMMAND_GROUP_LIST_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(Kind, 0, "Kind not 0");
}

void GP_CLI_COMMAND_GROUP_LIST_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (PChar->PParty)
    {
        PChar->PParty->ReloadPartyMembers(PChar);
    }
    else
    {
        // previous CPartyDefine was dropped or otherwise didn't work?
        PChar->pushPacket<CPartyDefinePacket>(nullptr, false);
    }
}
