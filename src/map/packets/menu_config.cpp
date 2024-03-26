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

#include "menu_config.h"

#include "entities/charentity.h"

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00B4
CMenuConfigPacket::CMenuConfigPacket(CCharEntity* PChar)
{
    this->setType(0xB4);
    this->setSize(0x18);

    std::memcpy(&data[0x04], &PChar->playerConfig, sizeof(SAVE_CONF));
    // (4)+4+4+4+4+2+1 -- napkin math, deleteme
    ref<uint8>(0x23) = PChar->m_GMlevel; // ? No way to know for sure if this is accurate...
    ref<uint8>(0x24) = PChar->search.language;
}