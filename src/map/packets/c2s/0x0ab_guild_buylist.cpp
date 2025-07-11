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

#include "0x0ab_guild_buylist.h"

#include "entities/charentity.h"
#include "packets/guild_menu_buy.h"

auto GP_CLI_COMMAND_GUILD_BUYLIST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(PChar->PGuildShop, nullptr, "Character does not have a guild shop");
}

void GP_CLI_COMMAND_GUILD_BUYLIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    PChar->pushPacket<CGuildMenuBuyPacket>(PChar, PChar->PGuildShop);
}
