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

#include "items/craft_state.h"
#include "items/item_id.h"
#include "items/transaction.h"

#include <common/types/maybe.h>

#include <array>
#include <memory>

class CCharEntity;
class CItem;

inline constexpr size_t MaxSlots = SynthMaxIngredients + 1; // crystal + 8 ingredients

struct SynthIngredient
{
    uint16 itemId{};
    uint8  invSlot{ 0xFF };
};

struct SynthOffer
{
    SynthIngredient                                  crystal{};
    std::array<SynthIngredient, SynthMaxIngredients> ingredients{};
};

class SynthTransaction : public Transaction
{
public:
    struct Slot
    {
        ItemId claimed{};
        uint16 itemId{ 0 };
        bool   saved{ false };
    };

    static auto start(CCharEntity* player, const SynthOffer& offer) -> std::unique_ptr<SynthTransaction>;

    SynthTransaction(xi::Badge<SynthTransaction>, CCharEntity* player);
    ~SynthTransaction() override;
    DISALLOW_COPY_AND_MOVE(SynthTransaction);

    void consumeCrystal();
    void markSaved(uint8 ingredientIdx);

    void setResultDelivery(CCraftState::Result result);

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

    auto reversible() const -> bool override;

private:
    auto claimAndLock(CItem* item) -> ItemId;

    CCharEntity*               player_{};
    std::array<Slot, MaxSlots> slots_{}; // [0] crystal, [1..8] ingredients

    Maybe<CCraftState::Result> pendingResult_;
};
