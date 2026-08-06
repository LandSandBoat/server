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

#include <memory>
#include <vector>

class CCharEntity;
class CItem;

// Transaction for one guild shop sale.
//
// start() claims every Free stack of the item it can, up to the requested quantity.
// Sales can span several stacks.
// Shop scripts only touch what has been properly claimed.
// Committing consumes claimed items and pays out.

class GuildSellTransaction : public Transaction
{
public:
    static auto start(CCharEntity* player, uint16 itemId, uint8 hintSlot, uint8 quantity) -> std::unique_ptr<GuildSellTransaction>;

    GuildSellTransaction(xi::Badge<GuildSellTransaction>, CCharEntity* player, uint16 itemId);
    ~GuildSellTransaction() override;

    DISALLOW_COPY_AND_MOVE(GuildSellTransaction);

    auto holds(const CItem* item) const -> bool override;
    auto claimed() const -> uint8;
    void setPayout(uint8 sold, uint32 unitPrice);

protected:
    auto doCommit() -> bool override;
    void doRollback() override;

private:
    struct Claim
    {
        CItem* item{ nullptr };
        uint8  invSlot{ 0xFF };
        uint8  quantity{ 0 };
    };

    void releaseAllClaims();

    CCharEntity*       player_{};
    uint16             itemId_{};
    uint8              claimed_{};
    uint8              sold_{};
    uint32             unitPrice_{};
    std::vector<Claim> claims_;
};
