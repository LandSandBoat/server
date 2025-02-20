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

#include <cstring>

#include "char_abilities.h"

#include "entities/charentity.h"

CCharAbilitiesPacket::CCharAbilitiesPacket(CCharEntity* PChar)
{
    this->setType(0xAC);
    this->setSize(0xE4);

    std::memcpy(buffer_.data() + 0x04, PChar->m_WeaponSkills, 32);
    std::memcpy(buffer_.data() + 0x44, PChar->m_Abilities, 64);
    std::memcpy(buffer_.data() + 0x84, PChar->m_PetCommands, 64);
    std::memcpy(buffer_.data() + 0xC4, PChar->m_TraitList, 18);
}
