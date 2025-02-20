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

#include "party_effects.h"
#include "entities/battleentity.h"
#include "party.h"
#include "status_effect_container.h"

CPartyEffectsPacket::CPartyEffectsPacket()
{
    this->setType(0x76);
    this->setSize(0xF4);
}

void CPartyEffectsPacket::AddMemberEffects(CBattleEntity* PMember)
{
    if (members == 5)
    {
        ShowWarning("Member count exceeds packet maximum.");
        return;
    }

    ref<uint32>(members * 0x30 + 0x04) = PMember->id;
    ref<uint16>(members * 0x30 + 0x08) = PMember->targid;
    ref<uint64>(members * 0x30 + 0x0C) = PMember->StatusEffectContainer->m_Flags;
    std::memcpy(buffer_.data() + (members * 0x30 + 0x14), PMember->StatusEffectContainer->m_StatusIcons, 32);
    ++members;
}
