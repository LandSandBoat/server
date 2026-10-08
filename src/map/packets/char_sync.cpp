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

#include "char_sync.h"

#include "entities/char_entity.h"
#include "status_effect_container.h"
#include "utils/mountutils.h"

CCharSyncPacket::CCharSyncPacket(CCharEntity* PChar)
{
    this->setType(0x67);
    this->setSize(0x28);

    ref<uint8>(0x04)  = 0x02;
    ref<uint8>(0x05)  = 0x09;
    ref<uint16>(0x06) = PChar->targid;
    ref<uint32>(0x08) = PChar->id;
    // ref<uint16>(0x0C) = PChar->PFellow ? PChar->PFellow->targid : 0

    ref<uint8>(0x10) = PChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::AlliedTags) ? 0x02 : 0x00; // 0x02 - Campaign Battle, 0x04 - Level Sync

    if (PChar->m_LevelRestriction && PChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::LevelSync))
    {
        if (PChar->PBattlefield == nullptr)
        {
            // Only display the level sync icon outside of BCNMs
            ref<uint8>(0x10) |= 0x04;
        }

        ref<uint8>(0x26) = PChar->m_LevelRestriction;
    }

    if (PChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Mounted))
    {
        const auto [ChocoboIndex, CustomProperties] = mountutils::packetDefinition(PChar);
        ref<uint16>(0x13)                           = PChar->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Mounted)->GetSubPower();
        ref<uint32>(0x18)                           = CustomProperties[0]; // Personal Chocobo model
        ref<uint32>(0x1C)                           = CustomProperties[1]; // Noble Chocobo
    }

    if (PChar->inMogHouse(xi::MogHouse::Visiting))
    {
        ref<uint32>(0x20) = PChar->m_moghouseID; // Owner of the Mog House being visited
    }

    ref<uint8>(0x24) = PChar->moghouse().isOpen(); // MogHouseFlag - Open to visitors
    ref<uint8>(0x25) = PChar->jobs.job[static_cast<uint8>(PChar->GetMJob())];
    // MogExpansionFlag - Is 2nd floor unlocked, the owner's when visiting
    const auto* POwner = PChar->moghouse().host();
    if (POwner == nullptr)
    {
        POwner = PChar;
    }

    ref<uint8>(0x27) = (POwner->profile.mhflag & 0x20) != 0;
}
