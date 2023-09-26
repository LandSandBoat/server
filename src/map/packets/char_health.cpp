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

#include "char_health.h"

#include "entities/charentity.h"
#include "entities/trustentity.h"

#include "monstrosity.h"

CCharHealthPacket::CCharHealthPacket(CCharEntity* PChar)
{
    this->setType(0xDF);
    this->setSize(0x28);

    ref<uint32>(0x04) = PChar->id;

    ref<uint32>(0x08) = PChar->health.hp;
    ref<uint32>(0x0C) = PChar->health.mp;
    ref<uint32>(0x10) = PChar->health.tp;

    ref<uint16>(0x14) = PChar->targid;

    ref<uint8>(0x16) = PChar->GetHPP();
    ref<uint8>(0x17) = PChar->GetMPP();

    if (PChar->m_PMonstrosity != nullptr)
    {
        ref<uint32>(0x1C) = monstrosity::GetPackedMonstrosityName(PChar);
    }

    if (!(PChar->nameflags.flags & FLAG_ANON))
    {
        ref<uint8>(0x20) = PChar->GetMJob();
        ref<uint8>(0x21) = PChar->GetMLevel();
        ref<uint8>(0x22) = PChar->GetSJob();
        ref<uint8>(0x23) = PChar->GetSLevel();
        ref<uint8>(0x24) = 0; // Master Level
        ref<uint8>(0x25) = 0; // Master Breaker
    }
}

CCharHealthPacket::CCharHealthPacket(CTrustEntity* PTrust)
{
    this->setType(0xDF);
    this->setSize(0x24);

    ref<uint32>(0x04) = PTrust->id;

    ref<uint32>(0x08) = PTrust->health.hp;
    ref<uint32>(0x0C) = PTrust->health.mp;
    ref<uint32>(0x10) = PTrust->health.tp;

    ref<uint16>(0x14) = PTrust->targid;

    ref<uint8>(0x16) = PTrust->GetHPP();
    ref<uint8>(0x17) = PTrust->GetMPP();

    ref<uint8>(0x20) = PTrust->GetMJob();
    ref<uint8>(0x21) = PTrust->GetMLevel();
    ref<uint8>(0x22) = PTrust->GetSJob();
    ref<uint8>(0x23) = PTrust->GetSLevel();
}
