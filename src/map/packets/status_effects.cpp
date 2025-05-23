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

#include "status_effects.h"
#include "common/timer.h"
#include "entities/charentity.h"
#include "status_effect_container.h"

CStatusEffectPacket::CStatusEffectPacket(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0xC8);

    int i = 0;

    std::fill(reinterpret_cast<uint16*>(buffer_.data() + 0x08), reinterpret_cast<uint16*>(buffer_.data() + 0x08) + 32, 0x00FF);

    ref<uint8>(0x04) = 0x09;
    ref<uint8>(0x06) = 0xC4;

    // clang-format off
    PChar->StatusEffectContainer->ForEachEffect([this, &i](CStatusEffect* PEffect)
    {
        if (PEffect->GetIcon() != 0)
        {
            auto durationRemaining = 0x7FFFFFFF;
            if (PEffect->GetDuration() > 0s && !PEffect->HasEffectFlag(EFFECTFLAG_HIDE_TIMER))
            {
                // this value overflows, but the client expects the overflowed timestamp and corrects it
                durationRemaining = timer::count_seconds(PEffect->GetStartTime() - timer::now() + PEffect->GetDuration());
                durationRemaining += earth_time::vanadiel_timestamp();
                durationRemaining *= 60;
            }
            ref<uint16>(0x08 + (i * 0x02)) = PEffect->GetIcon();
            ref<uint32>(0x48 + (i * 0x04)) = durationRemaining;
            ++i;
        }
    });
    // clang-format on
}
