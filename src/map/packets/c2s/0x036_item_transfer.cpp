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

#include "0x036_item_transfer.h"

#include "common/async.h"
#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "lua/luautils.h"
#include "packets/s2c/0x053_systemmes.h"
#include "status_effect_container.h"
#include "trade_container.h"

namespace
{
    const auto auditTrade = [](CCharEntity* PChar, CBaseEntity* PNpc, uint32_t itemId, uint8_t quantity)
    {
        if (settings::get<bool>("map.AUDIT_PLAYER_TRADES"))
        {
            const auto sender       = PChar->id;
            const auto senderName   = PChar->getName();
            const auto receiver     = PNpc->id;
            const auto receiverName = PNpc->getName();

            // clang-format off
            Async::getInstance()->submit([itemId, quantity, sender, senderName, receiver, receiverName]()
            {
                const auto tradeDate    = earth_time::timestamp();
                const auto query        = "INSERT INTO audit_trade(itemid, quantity, sender, sender_name, receiver, receiver_name, date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                if (!db::preparedStmt(query, itemId, quantity, sender, senderName, receiver, receiverName, tradeDate))
                {
                    ShowErrorFmt("Failed to log trade transaction (item: {}, quantity: {}, sender: {}, receiver: {}, date: {})", itemId, quantity, sender, receiver, tradeDate);
                }
            });
            // clang-format on
        }
    };
} // namespace

auto GP_CLI_COMMAND_ITEM_TRANSFER::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotMonstrosity(PChar)
        .range("ItemNum", ItemNum, 1, 9);
}

void GP_CLI_COMMAND_ITEM_TRANSFER::process(MapSession* PSession, CCharEntity* PChar) const
{
    // If PChar is invisible don't allow the trade
    if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE))
    {
        PChar->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, MsgStd::CannotWhileInvisible);
        return;
    }

    CBaseEntity* PNpc = PChar->GetEntity(ActIndex, TYPE_NPC | TYPE_MOB);

    // NPC must match UniqueNo and be within 6.0' of the player
    if (!PNpc ||
        PNpc->id != UniqueNo ||
        distance(PChar->loc.p, PNpc->loc.p) > 6.0f)
    {
        return;
    }

    // Only allow trading with mobs if it's status is an NPC
    if (PNpc->objtype == TYPE_MOB && PNpc->status != STATUS_TYPE::NORMAL)
    {
        return;
    }

    PChar->TradeContainer->Clean();

    for (int32 slotId = 0; slotId < ItemNum; ++slotId)
    {
        const uint8_t  invSlotId = PropertyItemIndexTbl[slotId];
        const uint32_t quantity  = ItemNumTbl[slotId];

        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotId);

        if (PItem == nullptr || PItem->getQuantity() < quantity)
        {
            ShowError("GP_CLI_COMMAND_ITEM_TRANSFER: %s trying to trade NPC %s with invalid item! ", PChar->getName(), PNpc->getName());
            return;
        }

        if (PItem->getReserve() > 0)
        {
            ShowError("GP_CLI_COMMAND_ITEM_TRANSFER: %s trying to trade NPC %s with reserved item! ", PChar->getName(), PNpc->getName());
            return;
        }

        auditTrade(PChar, PNpc, PItem->getID(), quantity);

        PItem->setReserve(quantity);
        PChar->TradeContainer->setItem(slotId, PItem->getID(), invSlotId, quantity, PItem);
    }

    luautils::OnTrade(PChar, PNpc);
    PChar->TradeContainer->unreserveUnconfirmed();
}
