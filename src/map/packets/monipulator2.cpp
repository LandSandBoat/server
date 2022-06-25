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

#include "monipulator2.h"


CMonipulatorPacket2::CMonipulatorPacket2(CCharEntity* PChar)
{
    this->setType(0x63);
    this->setSize(0xB4);

    memset(data + 4, 0, PACKET_SIZE - 4);

    std::array<uint8, 3> packet2 = { 0x04, 0x00, 0xB0 };
    memcpy(data + (0x04), &packet2, sizeof(packet2));
}
