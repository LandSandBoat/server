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

#pragma once

#include "base.h"
#include "enums/music_slot.h"

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x005F
// This packet is sent by the server to update a music file to be played.
class GP_SERV_COMMAND_MUSIC final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MUSIC, GP_SERV_COMMAND_MUSIC>
{
public:
    struct PacketData
    {
        MusicSlot Slot;
        uint16_t  MusicNum;
    };

    GP_SERV_COMMAND_MUSIC(MusicSlot slotId, uint16 trackId);
};
