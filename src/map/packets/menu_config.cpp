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

struct GP_SERV_CONFIG
{
    uint16_t    id : 9;
    uint16_t    size : 7;
    uint16_t    sync;
    SAVE_CONF   ConfData;       // PS2: ConfData
    uint8_t     unknown00;      // PS2: GmLevel
    languages_t PartyLanguages; // PS2: (New; did not exist.)
    uint8_t     unknown01[3];   // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00B4
CMenuConfigPacket::CMenuConfigPacket(CCharEntity* PChar)
{
    this->setType(0xB4);
    this->setSize(0x18);

    GP_SERV_CONFIG packet = {};

    packet.id       = 0xB4;
    packet.size     = roundUpToNearestFour(sizeof(GP_SERV_CONFIG)) / 4;
    packet.ConfData = PChar->playerConfig;

    std::memcpy(&packet.PartyLanguages, &PChar->search.language, sizeof(packet.PartyLanguages));

    std::memcpy(buffer_.data(), &packet, sizeof(GP_SERV_CONFIG));
}
