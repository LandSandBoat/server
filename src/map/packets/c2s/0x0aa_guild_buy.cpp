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

#include "common/settings.h"
#include "entities/char_entity.h"
#include "items/item.h"
#include "lua/luautils.h"
#include "packets/s2c/0x082_guild_buy.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

namespace
{

const auto auditPurchase = [](Scheduler& scheduler, CCharEntity* PChar, uint32_t itemId, uint8_t quantity, int32_t appliedGil)
{
    if (settings::get<bool>("map.AUDIT_PLAYER_VENDOR"))
    {
        const auto* PNpc = zoneutils::GetEntity(PChar->guildShopNpc_.UniqueNo, TYPE_NPC);

        const auto npcName = [PNpc]() -> std::string
        {
            if (PNpc)
            {
                return PNpc->getName();
            }

            return {};
        }();

        scheduler.postToWorkerThread(
            [itemId,
             quantity,
             buyer     = PChar->id,
             buyerName = PChar->getName(),
             appliedGil,
             npcId = PChar->guildShopNpc_.UniqueNo,
             npcName,
             zoneId = static_cast<uint16>(PChar->getZone())]()
            {
                // This might look ugly but the guild shop prices are roller per shop day in lua
                // We need to derive the prices from the applied gil since the prices change
                const auto totalPrice = static_cast<uint32>(-appliedGil);

                const auto basePrice = [&]() -> uint32
                {
                    if (quantity > 0)
                    {
                        return totalPrice / quantity;
                    }

                    return 0;
                }();

                if (!db::preparedStmt("INSERT INTO audit_vendor(itemid, quantity, seller, seller_name, direction, npcid, npc_name, zoneid, baseprice, totalprice, applied_gil, date) "
                                      "VALUES (?, ?, ?, ?, 'buy', ?, ?, ?, ?, ?, ?, UNIX_TIMESTAMP())",
                                      itemId,
                                      quantity,
                                      buyer,
                                      buyerName,
                                      npcId,
                                      npcName,
                                      zoneId,
                                      basePrice,
                                      totalPrice,
                                      appliedGil))
                {
                    ShowErrorFmt("Failed to log guild vendor purchase (item: {}, quantity: {}, buyer: {}, totalprice: {})", itemId, quantity, buyer, totalPrice);
                }
            });
    }
};

} // namespace

auto GP_CLI_COMMAND_GUILD_BUY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustNotEqual(PChar->guildShopNpc_.UniqueNo, 0, "Character does not have a guild shop")
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

    if (auto* PNpc = zoneutils::GetEntity(PChar->guildShopNpc_.UniqueNo, TYPE_NPC))
    {
        // Track the gil the player had before the transaction
        const uint32 gilBefore = PChar->getStorage(LOC_INVENTORY)->GetItem(0)->getQuantity();

        // onPlayerBuy returns { itemNo, count, tradeCode }; serialize it into the 0x082 result
        // (a rejection is { 0, 0, -1 }).
        const auto result = luautils::callGlobal<sol::table>("xi.guildShops.onPlayerBuy", PChar, PNpc, this->ItemNo, quantity);
        if (result.valid())
        {
            const auto itemNo    = result.get_or("itemNo", uint16{ 0 });
            const auto count     = result.get_or("count", uint8{ 0 });
            const auto tradeCode = result.get_or("tradeCode", int32{ 0 });
            PChar->pushPacket<GP_SERV_COMMAND_GUILD_BUY>(PChar, count, itemNo, static_cast<uint8>(tradeCode));

            // Audit the purchase if enabled
            const auto appliedGil = static_cast<int32>(PChar->getStorage(LOC_INVENTORY)->GetItem(0)->getQuantity()) - static_cast<int32>(gilBefore);
            if (tradeCode > 0 && appliedGil < 0)
            {
                // TODO: Don't pass around Scheduler& through PSession
                auditPurchase(*PSession->scheduler, PChar, itemNo, static_cast<uint8>(tradeCode), appliedGil);
            }
        }
    }
}
