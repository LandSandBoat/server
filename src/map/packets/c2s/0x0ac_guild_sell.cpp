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

#include "0x0ac_guild_sell.h"

#include "common/settings.h"
#include "entities/char_entity.h"
#include "items/transactions/guild_sell.h"
#include "lua/luautils.h"
#include "packets/s2c/0x084_guild_sell.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

namespace
{

const auto auditSale = [](Scheduler& scheduler, CCharEntity* PChar, uint32_t itemId, uint32_t basePrice, uint8_t quantity)
{
    if (settings::get<bool>("map.AUDIT_PLAYER_VENDOR"))
    {
        scheduler.postToWorkerThread(
            [itemId, quantity, seller = PChar->id, sellerName = PChar->getName(), basePrice]()
            {
                auto totalPrice = basePrice * quantity;

                const auto query = "INSERT INTO audit_vendor(itemid, quantity, seller, seller_name, baseprice, totalprice, date) VALUES (?, ?, ?, ?, ?, ?, UNIX_TIMESTAMP())";
                if (!db::preparedStmt(query, itemId, quantity, seller, sellerName, basePrice, totalPrice))
                {
                    ShowErrorFmt("Failed to log vendor sale (item: {}, quantity: {}, seller: {}, baseprice: {}, totalprice: {})",
                                 itemId,
                                 quantity,
                                 seller,
                                 basePrice,
                                 totalPrice);
                }
            });
    }
};

} // namespace

auto GP_CLI_COMMAND_GUILD_SELL::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Crafting })
        .mustNotEqual(PChar->guildShopNpc_.UniqueNo, 0, "Character does not have a guild shop")
        .range("ItemNum", this->ItemNum, 1, 99);
}

void GP_CLI_COMMAND_GUILD_SELL::process(MapSession* PSession, CCharEntity* PChar) const
{
    const CItem* PItem = xi::items::lookup(this->ItemNo);
    if (!PItem)
    {
        ShowWarning("User '%s' attempting to sell an invalid item to guild vendor!", PChar->getName());
        return;
    }

    // A guild shop never buys more than a single stack of an item per transaction.
    if (this->ItemNum > PItem->getStackSize())
    {
        PChar->pushPacket<GP_SERV_COMMAND_GUILD_SELL>(PChar, 0, 0, static_cast<uint8>(-4));
        return;
    }

    auto* PNpc = zoneutils::GetEntity(PChar->guildShopNpc_.UniqueNo, TYPE_NPC);
    if (!PNpc)
    {
        PChar->pushPacket<GP_SERV_COMMAND_GUILD_SELL>(PChar, 0, 0, static_cast<uint8>(-4));
        return;
    }

    // Lock the player's stacks before quoting: the shop only ever buys what we could claim.
    const auto transaction = GuildSellTransaction::start(PChar, this->ItemNo, this->PropertyItemIndex, this->ItemNum);
    if (!transaction || transaction->claimed() == 0)
    {
        PChar->pushPacket<GP_SERV_COMMAND_GUILD_SELL>(PChar, 0, 0, static_cast<uint8>(-4));
        return;
    }

    const auto result = luautils::callGlobal<sol::table>("xi.guildShops.onPlayerSell", PChar, PNpc, this->ItemNo, transaction->claimed());
    if (!result.valid())
    {
        PChar->pushPacket<GP_SERV_COMMAND_GUILD_SELL>(PChar, 0, 0, static_cast<uint8>(-4));
        return;
    }

    const auto itemNo = result.get_or("itemNo", uint16{ 0 });
    const auto count  = result.get_or("count", uint8{ 0 });
    const auto sold   = result.get_or("sold", uint8{ 0 });
    const auto price  = result.get_or("price", uint32{ 0 });

    // less sold than asked for is a partial fill, refusals keep the script's own code
    auto tradeCode = int32{ sold };
    if (sold == 0)
    {
        tradeCode = result.get_or("tradeCode", int32{ -4 });
    }
    else if (sold < this->ItemNum)
    {
        tradeCode = -1;
    }

    if (sold > 0)
    {
        transaction->setPayout(sold, price);
        if (!transaction->commit())
        {
            PChar->pushPacket<GP_SERV_COMMAND_GUILD_SELL>(PChar, 0, 0, static_cast<uint8>(-4));
            return;
        }

        auditSale(*PSession->scheduler, PChar, itemNo, price, sold);
    }

    PChar->pushPacket<GP_SERV_COMMAND_GUILD_SELL>(PChar, count, itemNo, static_cast<uint8>(tradeCode));
}
