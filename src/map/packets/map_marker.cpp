/*
===========================================================================

Copyright (c) 2010-2018 Darkstar Dev Teams

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

#include "map_marker.h"

#include "../entities/charentity.h"
#include "../utils/charutils.h"

CMapMarkerPacket::CMapMarkerPacket(CCharEntity* PChar)
{
    this->id(0x063);
    this->length(0x48);

    ref<uint8>(0x04) = 0x06;

    // Homepoint teleport masks
    ref<uint16>(0x08) = PChar->teleport.homepoint.access[0] & 0xFFFF;
    ref<uint16>(0x0A) = (PChar->teleport.homepoint.access[0] & 0xFFFF0000) >> 16;
    ref<uint16>(0x0C) = PChar->teleport.homepoint.access[1] & 0xFFFF;
    ref<uint16>(0x0E) = (PChar->teleport.homepoint.access[1] & 0xFFFF0000) >> 16;
    ref<uint16>(0x10) = PChar->teleport.homepoint.access[2] & 0xFFFF;
    ref<uint16>(0x12) = (PChar->teleport.homepoint.access[2] & 0xFFFF0000) >> 16;
    ref<uint16>(0x14) = PChar->teleport.homepoint.access[3] & 0xFFFF;
    ref<uint16>(0x16) = (PChar->teleport.homepoint.access[3] & 0xFFFF0000) >> 16;

    // TODO: Cavernous Maws, Abyssea Maws, Survival Guides
}
