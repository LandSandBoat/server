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

#include "0x062_clistatus2.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_CLISTATUS2::GP_SERV_COMMAND_CLISTATUS2(const CCharEntity* PChar)
{
    auto& packet = this->data();

    std::memcpy(packet.skill_base, &PChar->WorkingSkills, sizeof(packet.skill_base));

    // Remove automaton skills from this menu (they are in another packet)
    packet.skill_base[22] = 0x8000; // Offset 0xAC - 0x80 = 0x2C, 0x2C/2 = 22
    packet.skill_base[23] = 0x8000; // Offset 0xAE - 0x80 = 0x2E, 0x2E/2 = 23
    packet.skill_base[24] = 0x8000; // Offset 0xB0 - 0x80 = 0x30, 0x30/2 = 24
}
