/*
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

#include "common/socket.h"

#include "char_sync.h"

#include "../entities/charentity.h"
#include "../status_effect_container.h"

CCharSyncPacket::CCharSyncPacket(CCharEntity* PChar)
{
    this->setType(0x67);
    this->setSize(0x28);

    ref<uint8>(0x04)  = 0x02;
    ref<uint8>(0x05)  = 0x09;
    ref<uint16>(0x06) = PChar->targid;
    ref<uint32>(0x08) = PChar->id;
    // ref<uint16>(0x0C) = PChar->PFellow ? PChar->PFellow->targid : 0

    ref<uint8>(0x10) = PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ALLIED_TAGS) ? 2 : 0; // 0x02 - Campaign Battle, 0x04 - Level Sync

    if (PChar->m_LevelRestriction && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
    {
        if (PChar->PBattlefield == nullptr)
        {
            // Only display the level sync icon outside of BCNMs
            ref<uint8>(0x10) |= 4;
        }

        ref<uint8>(0x26) = PChar->m_LevelRestriction;
    }

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        ref<uint16>(0x13) = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower();
        ref<uint32>(0x18) = PChar->m_FieldChocobo;
    }

    ref<uint8>(0x25) = PChar->jobs.job[PChar->GetMJob()];

    // Moghouse menu flags?
    auto mhflag             = PChar->profile.mhflag;
    bool enableChangeFloors = (mhflag & 0x04) && (mhflag & 0x02) && (mhflag & 0x01) ? 0x01 : 0x00;
    ref<uint8>(0x27)        = enableChangeFloors;
}
