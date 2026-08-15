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

class CCharEntity;
class CItem;

// What a player has put in an NPC's trade window.
//
// stage() claims each offered stack, so nothing can equip, sell or bazaar it while the script
// decides what to do. A script marks what it wants with confirm(), and everything it did not
// want is let go by releaseUnconfirmed() as soon as onTrade returns - matching what the window
// shows the player.
//
// The claim on a confirmed slot outlives onTrade, because a script may open an event and only
// consume once that event finishes, many ticks later. It ends at consumeConfirmed/consumeAll, or
// when the next trade replaces this one.
//
// This owns the item pointers and the confirmed counts. CTradeContainer keeps only the
// description of the offer - ids, slots and quantities - which is what the script API reads.

class NpcTradeTransaction final : public Transaction
{
public:
    static auto start(CCharEntity* player) -> std::unique_ptr<NpcTradeTransaction>;

    NpcTradeTransaction(xi::Badge<NpcTradeTransaction>, CCharEntity* player);
    ~NpcTradeTransaction() override;

    DISALLOW_COPY_AND_MOVE(NpcTradeTransaction);

    [[nodiscard]] auto stage(uint8 tradeSlot, CItem* item, uint32 quantity) -> bool;

    auto item(uint8 tradeSlot) -> CItem*;

    // How much of the slot was offered, and how much of that the script asked for
    auto quantity(uint8 tradeSlot) const -> uint32;
    auto confirmedQuantity(uint8 tradeSlot) const -> uint32;
    auto confirm(uint8 tradeSlot, uint32 quantity) -> bool;

    // Confirms an offered stack by what it is rather than where it sits in the window
    [[nodiscard]] auto confirmById(uint16 itemId, uint32 quantity) -> bool;

    // Everything the script passed on goes back to the player as soon as onTrade returns
    void releaseUnconfirmed();

    // Consumes what the script confirmed, then closes. False if any of it could not be taken
    [[nodiscard]] auto consumeConfirmed() -> bool;

    // Consumes every staged slot in full, then closes. False if any of it could not be taken
    [[nodiscard]] auto consumeAll() -> bool;

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    struct Slot
    {
        // The offer outlives the claim, so the stack is resolved on demand rather than remembered
        ItemId offered{};
        uint32 quantity{};
        uint32 confirmed{};
    };

    // The stack an offer refers to, re-claimed if it was let go after onTrade
    auto resolve(Slot& slot) -> CItem*;

    // Takes `quantity` from the slot's stack and drops the claim on whatever is left
    [[nodiscard]] auto consumeSlot(Slot& slot, uint32 quantity) -> bool;

    CCharEntity*                     player_{};
    std::array<Slot, CONTAINER_SIZE> slots_{};
};
