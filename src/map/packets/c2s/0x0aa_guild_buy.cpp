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

#include "0x0aa_guild_buy.h"

#include "entities/char_entity.h"
#include "items/item.h"
#include "lua/luautils.h"
#include "packets/s2c/0x082_guild_buy.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_GUILD_BUY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustNotEqual(PChar->guildShopNpc_.id, 0, "Character does not have a guild shop")
        .range("ItemNum", this->ItemNum, 1, 99)
        .mustEqual(this->PropertyItemIndex, 0, "PropertyItemIndex not 0");
}

void GP_CLI_COMMAND_GUILD_BUY::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint8        quantity = this->ItemNum;
    const CItem* PItem    = xi::items::lookup(this->ItemNo);
    if (!PItem)
    {
        ShowWarning("User '%s' attempting to buy an invalid item from guild vendor!", PChar->getName());
        return;
    }

    // You can't buy more than a stack at once; retail turns this away instead of quietly clamping it.
    if (quantity > PItem->getStackSize())
    {
        PChar->pushPacket<GP_SERV_COMMAND_GUILD_BUY>(PChar, 0, 0, static_cast<uint8>(-1));
        return;
    }

    if (auto* PNpc = zoneutils::GetEntity(PChar->guildShopNpc_.id, TYPE_NPC))
    {
        // onPlayerBuy returns { itemNo, count, trade }; serialize it into the 0x082 result
        // (a rejection is { 0, 0, -1 }).
        const auto result = luautils::callGlobal<sol::table>("xi.guildShops.onPlayerBuy", PChar, PNpc, this->ItemNo, quantity);
        if (result.valid())
        {
            const auto itemNo = result.get_or("itemNo", uint16{ 0 });
            const auto count  = result.get_or("count", uint8{ 0 });
            const auto trade  = result.get_or("trade", int32{ 0 });
            PChar->pushPacket<GP_SERV_COMMAND_GUILD_BUY>(PChar, count, itemNo, static_cast<uint8>(trade));
        }
    }
}
