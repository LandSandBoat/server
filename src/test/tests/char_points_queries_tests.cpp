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
#include <limits>
#include <string>
#include <utility>
#include <vector>

namespace
{

using Range = std::pair<int64, int64>;

template <typename T>
constexpr auto rangeOf() -> Range
{
    return Range{ std::numeric_limits<T>::min(), std::numeric_limits<T>::max() };
}

// The range a char_points column can hold, from its SQL type.
auto rangeOf(const std::string& type) -> Range
{
    const auto isUnsigned = type.contains("unsigned");
    if (type.starts_with("tinyint"))
    {
        if (isUnsigned)
        {
            return rangeOf<uint8>();
        }

        return rangeOf<int8>();
    }

    if (type.starts_with("smallint"))
    {
        if (isUnsigned)
        {
            return rangeOf<uint16>();
        }

        return rangeOf<int16>();
    }

    if (type.starts_with("int"))
    {
        if (isUnsigned)
        {
            return rangeOf<uint32>();
        }

        return rangeOf<int32>();
    }

    return Range{ 0, 0 };
}

} // namespace

TEST_CASE("charutils::charPointsQueries matches every char_points column", "[database]")
{
    const auto rset = db::preparedStmt("SELECT COLUMN_NAME AS name, COLUMN_TYPE AS type FROM information_schema.COLUMNS "
                                       "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'char_points' AND COLUMN_NAME != 'charid'");
    REQUIRE(rset);

    auto schema = std::vector<std::pair<std::string, Range>>();
    while (rset->next())
    {
        schema.emplace_back(rset->get<std::string>("name"), rangeOf(rset->get<std::string>("type")));
    }

    std::ranges::sort(schema);

    auto listed = std::vector<std::pair<std::string, Range>>();
    for (const auto& queries : charutils::charPointsQueries)
    {
        listed.emplace_back(std::string(queries.column.name), Range{ queries.column.min, queries.column.max });
    }

    std::ranges::sort(listed);

    CHECK(listed == schema);
}
