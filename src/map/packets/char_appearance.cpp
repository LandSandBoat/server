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

#include "char_appearance.h"
#include "entities/charentity.h"

CCharAppearancePacket::CCharAppearancePacket(CCharEntity* PChar)
{
    this->setType(0x51);
    this->setSize(0x18);

    look_t* look      = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);
    ref<uint8>(0x04)  = look->face;
    ref<uint8>(0x05)  = look->race;
    ref<uint16>(0x06) = (PChar->menuConfigFlags.flags & NFLAG_DISPLAY_HEAD) ? 0x0 : look->head + 0x1000;
    ref<uint16>(0x08) = look->body + 0x2000;
    ref<uint16>(0x0A) = look->hands + 0x3000;
    ref<uint16>(0x0C) = look->legs + 0x4000;
    ref<uint16>(0x0E) = look->feet + 0x5000;
    ref<uint16>(0x10) = look->main + 0x6000;
    ref<uint16>(0x12) = look->sub + 0x7000;
    ref<uint16>(0x14) = look->ranged + 0x8000;

    if (PChar->m_Costume2 != 0)
    {
        ref<uint16>(0x04) = PChar->m_Costume2;
        ref<uint16>(0x14) = 0xFFFF;
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        ref<uint16>(0x04) = PChar->m_PMonstrosity->Look;
        ref<uint16>(0x14) = 0xFFFF;
    }
}
