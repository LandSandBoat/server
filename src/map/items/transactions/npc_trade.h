/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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
#include "common/types/badge.h"

#include "item_container.h"
#include "items/item_id.h"
#include "items/transaction.h"
#include "trade_container.h"

#include <array>
#include <memory>
#include <string>
#include <vector>

class CBaseEntity;
class CCharEntity;
class CItem;

// stage() claims each offered stack.
// A script confirms the slots it will take, and releaseUnconfirmed() gives the rest back as soon as onTrade returns.
//
// A confirmed slot keeps its claim past onTrade, since a script may open an event and consume only when that event finishes, many ticks later.
// It ends at consumeConfirmed/consumeAll, when the next trade replaces this one, at the end of the event, or when the player leaves the zone.
//
// The claims and confirmed counts live here.
// CTradeContainer keeps only the offer description - ids, slots and quantities - which is what the script API reads.

class NpcTradeTransaction final : public Transaction
{
public:
    static auto start(CCharEntity* player, const CBaseEntity* npc) -> std::unique_ptr<NpcTradeTransaction>;

    NpcTradeTransaction(xi::Badge<NpcTradeTransaction>, CCharEntity* player, const CBaseEntity* npc);
    ~NpcTradeTransaction() override;

    DISALLOW_COPY_AND_MOVE(NpcTradeTransaction);

    [[nodiscard]] auto stage(uint8 tradeSlot, CItem* item, uint32 quantity) -> bool;

    auto item(uint8 tradeSlot) -> CItem*;

    auto quantity(uint8 tradeSlot) const -> uint32;
    auto confirm(uint8 tradeSlot, uint32 quantity) -> bool;

    [[nodiscard]] auto confirmById(uint16 itemId, uint32 quantity) -> bool;

    void releaseUnconfirmed();

    // Consumes what the script confirmed, then closes. All or nothing: false rolls everything back
    [[nodiscard]] auto consumeConfirmed() -> bool;

    // Consumes every staged slot in full, then closes. All or nothing: false rolls everything back
    [[nodiscard]] auto consumeAll() -> bool;

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    struct Slot
    {
        // the offer outlives the claim, so the stack is resolved on demand
        ItemId offered{};
        uint32 quantity{};
        uint32 confirmed{};
    };

    // resolves the offered stack, re-claiming it if the claim was released after onTrade
    auto resolve(Slot& slot) -> CItem*;

    struct TradedItem
    {
        uint16 itemId{};
        uint32 qty{};
    };

    // everything saved from the offer, for auditing once the trade is successful
    auto tradedItems(bool confirmedOnly) const -> std::vector<TradedItem>;

    // takes quantity from the slot and clears it
    [[nodiscard]] auto consumeSlot(Slot& slot, uint32 quantity) -> bool;

    CCharEntity*                     player_{};
    uint32                           npcId_{};
    std::string                      npcName_;
    std::array<Slot, CONTAINER_SIZE> slots_{};
};
