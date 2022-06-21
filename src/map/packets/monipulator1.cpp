/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "monipulator1.h"

CMonipulatorPacket1::CMonipulatorPacket1(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0xDC);

    ref<uint8>(0x04) = 0x03; // Update Type
    ref<uint8>(0x06) = 0xD8; // Variable Data Size

    ref<uint8>(0x08)  = 0; // Species
    ref<uint16>(0x0A) = 0; // Flags?
    ref<uint8>(0x0C)  = 0; // Monstrosity Rank (0 = Mon, 1 = NM, 2 = HNM)

    ref<uint16>(0x12) = 0; // Infamy

    std::memset(data + 0x1C, 0, 64);  // Instinct Battlefield 1
    std::memset(data + 0x5C, 0, 128); // Monster Level Char Field
}
