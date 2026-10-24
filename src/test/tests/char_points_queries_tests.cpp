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

#include "map/utils/char_points_queries.h"

#include <common/database.h>

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <string>
#include <vector>

TEST_CASE("charutils::charPointsQueries covers every char_points column", "[database]")
{
    auto columns = db::getTableColumnNames("char_points");
    std::erase(columns, "charid");
    std::ranges::sort(columns);

    auto listed = std::vector<std::string>();
    for (const auto& queries : charutils::charPointsQueries)
    {
        listed.emplace_back(queries.column);
    }
    std::ranges::sort(listed);

    CHECK(listed == columns);
}
