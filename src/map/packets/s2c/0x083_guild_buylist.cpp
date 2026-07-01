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

#include "0x083_guild_buylist.h"

#include "entities/char_entity.h"
#include "item_container.h"

GP_SERV_COMMAND_GUILD_BUYLIST::GP_SERV_COMMAND_GUILD_BUYLIST(CCharEntity* PChar, const std::vector<GP_GUILD_ITEM>& items)
{
    if (PChar == nullptr)
    {
        ShowError("GP_SERV_COMMAND_GUILD_BUYLIST - PChar was null.");
        return;
    }

    auto& packet = this->data();

    uint8 ItemCount   = 0;
    uint8 PacketCount = 0;

    for (const auto& item : items)
    {
        if (ItemCount == 30)
        {
            packet.Count = ItemCount;
            packet.Stat  = (PacketCount == 0 ? 0x40 : PacketCount);

            PChar->pushPacket(this->copy());

            ItemCount = 0;
            PacketCount++;

            std::memset(&packet, 0, sizeof(PacketData));
        }

        packet.List[ItemCount] = item;
        ItemCount++;
    }

    packet.Count = ItemCount;
    packet.Stat  = PacketCount + 0x80;
}
