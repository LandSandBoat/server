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

#include "0x0ab_guild_buylist.h"

#include "entities/char_entity.h"
#include "lua/luautils.h"
#include "packets/s2c/0x083_guild_buylist.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_GUILD_BUYLIST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustNotEqual(PChar->guildShopNpc_.UniqueNo, 0, "Character does not have a guild shop");
}

void GP_CLI_COMMAND_GUILD_BUYLIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (auto* PNpc = zoneutils::GetEntity(PChar->guildShopNpc_.UniqueNo, TYPE_NPC))
    {
        const auto items = luautils::callGlobal<sol::table>("xi.guildShops.onBuyList", PChar, PNpc);

        std::vector<GP_GUILD_ITEM> list;
        list.reserve(items.size());
        for (std::size_t i = 1; i <= items.size(); ++i)
        {
            const sol::object obj = items[i];
            if (!obj.is<sol::table>())
            {
                continue;
            }

            const auto    entry = obj.as<sol::table>();
            GP_GUILD_ITEM gpItem{
                .ItemNo = entry.get_or("id", static_cast<uint16>(0)),
                .Count  = entry.get_or("count", static_cast<uint8>(0)),
                .Max    = entry.get_or("max", static_cast<uint8>(0)),
                .Price  = entry.get_or("price", static_cast<int32>(0)),
            };
            list.push_back(gpItem);
        }

        PChar->pushPacket<GP_SERV_COMMAND_GUILD_BUYLIST>(PChar, list);
    }
}
