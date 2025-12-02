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

#include "common/cbasetypes.h"

#include "0x083_guild_buylist.h"
#include "base.h"

class CCharEntity;
class CItemContainer;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0085
// This packet is sent by the server to inform the client of a guild shops item list it is accepting for player sales.
class GP_SERV_COMMAND_GUILD_SELLLIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_GUILD_SELLLIST, GP_SERV_COMMAND_GUILD_SELLLIST>
{
public:
    struct PacketData
    {
        GP_GUILD_ITEM List[30];
        uint8_t       Count;
        uint8_t       Stat;
    };

    GP_SERV_COMMAND_GUILD_SELLLIST(CCharEntity* PChar, const CItemContainer* PGuild);
};
