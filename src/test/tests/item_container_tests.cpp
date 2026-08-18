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

//
// CItemContainer bookkeeping tests.
//
// The container tracks how many slots are taken separately from the items
// themselves, and every caller reads that count rather than counting the
// items. Clear() has to keep the two in step.
//

#include "map/item_container.h"
#include "map/items/item.h"

#include <catch2/catch_test_macros.hpp>

#include <memory>

TEST_CASE("CItemContainer Clear resets the item count", "[item_container]")
{
    auto container = CItemContainer(LOC_TEMPITEMS);

    container.SetSize(10);

    for (auto i = 0; i < 3; ++i)
    {
        container.InsertItem(std::make_unique<CItem>(static_cast<uint16>(4096 + i)));
    }

    REQUIRE(container.GetFreeSlotsCount() == 7);

    container.Clear();

    SECTION("the slots the cleared items held come back")
    {
        REQUIRE(container.GetFreeSlotsCount() == 10);
    }

    SECTION("the container can then shrink past what it used to hold")
    {
        // SetSize refuses any size below the count, so a stale count pins the container open.
        REQUIRE(container.SetSize(1) == 1);
    }
}
