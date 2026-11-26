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

#include "data/enums/msg_basic.h"

#include <catch2/catch_test_macros.hpp>

#include <utility>

using MsgBasicTraits = xi::data::EnumTraits<xi::MsgBasic>;

TEST_CASE("msg basic: names decode to the retail message ids", "[data][enum]")
{
    CHECK(std::to_underlying(MsgBasicTraits::fromName("none")) == 0);
    CHECK(std::to_underlying(MsgBasicTraits::fromName("hit_dmg")) == 1);
    CHECK(std::to_underlying(MsgBasicTraits::fromName("not_enough_mp")) == 34);
    CHECK(std::to_underlying(MsgBasicTraits::fromName("cannot_in_this_area")) == 40);
    CHECK(std::to_underlying(MsgBasicTraits::fromName("alter_ego_upgrade")) == 828);
    CHECK(MsgBasicTraits::toName(xi::MsgBasic::CannotInThisArea) == "cannot_in_this_area");
}
