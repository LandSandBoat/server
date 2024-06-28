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

#include "change_music.h"

CChangeMusicPacket::CChangeMusicPacket(uint16 BlockID, uint16 MusicTrackID)
{
    // Block IDs:
    // 0 Background Music (Day time, 7:00 -> 18:00)
    // 1 Background Music (Night time, 18:00 -> 7:00)
    // 2 SoloBattle Music
    // 3 Party Battle Music
    // 4 Chocobo/Mount Music

    this->setType(0x5F);
    this->setSize(0x08);

    ref<uint16>(0x04) = BlockID;      // block
    ref<uint16>(0x06) = MusicTrackID; // music
}
