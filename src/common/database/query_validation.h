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

#include <common/database/result_set.h>

#include <array>
#include <string_view>

namespace db::detail
{

constexpr auto isQueryWhitespace(char c) noexcept -> bool
{
    return c == ' ' || c == '\t' || c == '\r' || c == '\n';
}

constexpr auto toUpperAscii(char c) noexcept -> char
{
    if (c >= 'a' && c <= 'z')
    {
        return static_cast<char>(c - 'a' + 'A');
    }

    return c;
}

constexpr auto equalsIgnoreCaseAscii(std::string_view lhs, std::string_view rhs) noexcept -> bool
{
    if (lhs.size() != rhs.size())
    {
        return false;
    }

    for (std::size_t i = 0; i < lhs.size(); ++i)
    {
        if (toUpperAscii(lhs[i]) != toUpperAscii(rhs[i]))
        {
            return false;
        }
    }

    return true;
}

// Inspect the leading keyword of a query to classify it as a Select (queryable),
// Update (rows-affected only), or Invalid query.
[[nodiscard]] constexpr auto validateQueryLeadingKeyword(std::string_view query) noexcept -> ResultSetType
{
    const auto start = query.find_first_not_of(" \t\r\n");
    if (start == std::string_view::npos)
    {
        return ResultSetType::Invalid;
    }

    auto end = start;
    while (end < query.size() && !isQueryWhitespace(query[end]))
    {
        ++end;
    }

    const auto keyword = query.substr(start, end - start);

    struct KeywordEntry
    {
        std::string_view keyword;
        ResultSetType    type;
    };

    constexpr std::array<KeywordEntry, 14> entries{ {
        { "SELECT", ResultSetType::Select },
        { "SHOW", ResultSetType::Select },
        { "INSERT", ResultSetType::Update },
        { "UPDATE", ResultSetType::Update },
        { "DELETE", ResultSetType::Update },
        { "REPLACE", ResultSetType::Update },
        { "CREATE", ResultSetType::Update },
        { "ALTER", ResultSetType::Update },
        { "DROP", ResultSetType::Update },
        { "TRUNCATE", ResultSetType::Update },
        { "SET", ResultSetType::Update },
        { "START", ResultSetType::Update },
        { "COMMIT", ResultSetType::Update },
        { "ROLLBACK", ResultSetType::Update },
    } };

    for (const auto& entry : entries)
    {
        if (equalsIgnoreCaseAscii(keyword, entry.keyword))
        {
            return entry.type;
        }
    }

    return ResultSetType::Invalid;
}

// Sanity-check the body of a query: reject stray "{}" format holes and ';'.
//
// NOTE: We shouldn't be checking for the presence of '%', as this
//     : is the SQL wildcard character.
[[nodiscard]] constexpr auto validateQueryContent(std::string_view query) noexcept -> bool
{
    return !query.contains("{}") && !query.contains(';');
}

} // namespace db::detail
