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

#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "items/transactions/npc_trade.h"
#include "lua/luautils.h"
#include "packets/s2c/0x053_systemmes.h"
#include "status_effect_container.h"
#include "trade_container.h"

#include <algorithm>
#include <array>

namespace
{

// 8 trade window slots plus gil
constexpr uint8 MAX_TRADE_SLOTS = 9;

} // namespace

auto GP_CLI_COMMAND_ITEM_TRANSFER::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Monstrosity })
        .range("ItemNum", this->ItemNum, 1, MAX_TRADE_SLOTS);
}

void GP_CLI_COMMAND_ITEM_TRANSFER::process(MapSession* PSession, CCharEntity* PChar) const
{
    // If PChar is invisible don't allow the trade
    if (PChar->StatusEffectContainer->HasStatusEffectByFlag(xi::StatusEffectFlag::Invisible))
    {
        PChar->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, MsgStd::CannotWhileInvisible);
        return;
    }

    CBaseEntity* PNpc = PChar->GetEntity(this->ActIndex, TYPE_NPC | TYPE_MOB);

    // NPC must match UniqueNo and be within 6.0' of the player
    if (!PNpc ||
        PNpc->id != this->UniqueNo ||
        distance(PChar->loc.p, PNpc->loc.p) > 6.0f)
    {
        return;
    }

    // Only allow trading with mobs if it's status is an NPC
    if (PNpc->objtype == TYPE_MOB && PNpc->status != xi::Status::Normal)
    {
        return;
    }

    // close any previous offer before this one replaces it
    if (auto* previous = PChar->activeTransaction<NpcTradeTransaction>())
    {
        PChar->removeTransaction(previous);
    }

    PChar->TradeContainer->Clean();

    std::array<CItem*, MAX_TRADE_SLOTS> tradeItems{};

    for (int32 slotId = 0; slotId < this->ItemNum; ++slotId)
    {
        const uint8_t  invSlotId = this->PropertyItemIndexTbl[slotId];
        const uint32_t quantity  = this->ItemNumTbl[slotId];

        if (quantity == 0)
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_TRANSFER: {} tried to trade NPC {} with zero quantity in slot {}!", PChar->getName(), PNpc->getName(), invSlotId);
            return;
        }

        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotId);

        if (!PItem)
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_TRANSFER: {} trying to trade NPC {} with an empty inventory slot {}!", PChar->getName(), PNpc->getName(), invSlotId);
            return;
        }

        if (PItem->getQuantity() < quantity)
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_TRANSFER: {} trying to trade NPC {} with {} of item {} ({}) they do not have!", PChar->getName(), PNpc->getName(), quantity, PItem->getName(), PItem->getID());
            return;
        }

        if (std::find(tradeItems.begin(), tradeItems.begin() + slotId, PItem) != tradeItems.begin() + slotId)
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_TRANSFER: {} trying to trade NPC {} with duplicate inventory slot {}!", PChar->getName(), PNpc->getName(), invSlotId);
            return;
        }

        if (PItem->isBusy())
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_TRANSFER: {} trying to trade NPC {} with locked item {} ({})!", PChar->getName(), PNpc->getName(), PItem->getName(), PItem->getID());
            return;
        }

        tradeItems[slotId] = PItem;
    }

    auto* transaction = PChar->addTransaction(NpcTradeTransaction::start(PChar, PNpc));
    if (!transaction)
    {
        return;
    }

    for (int32 slotId = 0; slotId < this->ItemNum; ++slotId)
    {
        CItem*         PItem    = tradeItems[slotId];
        const uint32_t quantity = this->ItemNumTbl[slotId];

        if (!transaction->stage(static_cast<uint8>(slotId), PItem, quantity))
        {
            ShowErrorFmt("GP_CLI_COMMAND_ITEM_TRANSFER: {} could not offer item {} ({}) to NPC {}", PChar->getName(), PItem->getName(), PItem->getID(), PNpc->getName());
            PChar->removeTransaction(transaction);
            PChar->TradeContainer->Clean();

            return;
        }

        PChar->TradeContainer->setItem(slotId, PItem->getID(), PItem->getSlotID(), quantity);
    }

    luautils::OnTrade(PChar, PNpc);

    // looked up again rather than reused: a script can finish the trade from onTrade, which destroys the transaction
    if (auto* offer = PChar->activeTransaction<NpcTradeTransaction>())
    {
        offer->releaseUnconfirmed();
    }

    if (PChar->isInEvent())
    {
        // Retail accurate: If the trade started an event then any current synth is a crit fail.
        if (PChar->isCrafting())
        {
            charutils::forceSynthCritFail("GP_CLI_COMMAND_ITEM_TRANSFER", PChar);
        }
    }
}
