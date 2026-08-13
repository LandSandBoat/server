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
#include "items/transaction.h"

#include <array>

class CCharEntity;
class CItem;

// The trade-slot echoes carry this in ItemNo when a slot is empty
inline constexpr uint16 EmptyTradeSlotItemNo = 0xFFFF;

class PlayerTradeTransaction : public Transaction
{
public:
    static constexpr size_t MaxSlots = 9;
    static constexpr uint8  GilSlot  = 0; // Gil is always in slot 0

    // Registers on the initiator. Returns nullptr if refused, caller cleans up TradePending
    static auto start(CCharEntity* initiator, CCharEntity* target) -> PlayerTradeTransaction*;

    // Cancel for `leaving`, whether or not the transaction got as far as being created
    static void cancel(CCharEntity* leaving);

    PlayerTradeTransaction(xi::Badge<PlayerTradeTransaction>, CCharEntity* initiator, CCharEntity* target);
    ~PlayerTradeTransaction() override;
    DISALLOW_COPY_AND_MOVE(PlayerTradeTransaction);

    auto holds(const CItem* item) const -> bool override;

    // Stage or clear a slot, qty 0 releases. Clears both acceptances and pushes the packets
    auto setSlot(CCharEntity* who, uint8 transactionSlot, uint8 inventorySlot, uint16 expectedItemId, uint32 qty) -> CItem*;

    // Returns true once both sides have accepted
    auto accept(const CCharEntity* who) -> bool;

    // Both close the transaction out, leaving it destroyed
    void abort(CCharEntity* leaving);
    void commitAndClose();

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    struct Slot
    {
        CItem* item{ nullptr };
        uint8  invSlot{ 0xFF };
        uint32 qty{ 0 };
    };

    struct Side
    {
        CCharEntity*               PChar{};
        std::array<Slot, MaxSlots> slots{};
        bool                       accepted{};
    };

    auto sideOf(const CCharEntity* who) -> Side*;
    auto partnerOf(const CCharEntity* who) const -> CCharEntity*;

    void        releaseSlot(Slot& slot) const;
    void        closeAndRemove();
    static auto canReceive(const Side& sender, CCharEntity* receiver) -> bool;

    std::array<Side, 2> sides_{};
};
