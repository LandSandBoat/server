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

#include "common/xi.h"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("bitset ignores positions past the end", "[bitset]")
{
    xi::bitset<4096> bits{};

    CHECK_FALSE(bits.test(4096));
    CHECK_FALSE(bits.test(65535));

    bits.set(4096);
    bits.flip(65535);
    bits[8192] = true;

    CHECK(bits.none());
    CHECK_FALSE(bits[4096]);
}

TEST_CASE("bitset stores the last valid bit", "[bitset]")
{
    xi::bitset<4096> bits{};

    bits.set(4095);

    CHECK(bits.test(4095));
    CHECK_FALSE(bits.none());
}
