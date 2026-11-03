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

#include <algorithm>
#include <array>
#include <cstddef>
#include <string_view>
#include <utility>

namespace db::detail
{

[[nodiscard]] constexpr auto isWordCharacter(const char c) noexcept -> bool
{
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '_';
}

[[nodiscard]] constexpr auto toUpperASCII(const char c) noexcept -> char
{
    if (c >= 'a' && c <= 'z')
    {
        return static_cast<char>(c - 'a' + 'A');
    }

    return c;
}

// Inspect the leading keyword of a query to classify it as a Select (queryable),
// Update (rows-affected only), or Invalid query.
[[nodiscard]] constexpr auto validateQueryLeadingKeyword(std::string_view query) -> ResultSetType
{
    constexpr auto whitespace = std::string_view(" \t\r\n");
    constexpr auto keywords   = std::array{
        std::pair{ std::string_view("SELECT"), ResultSetType::Select },
        std::pair{ std::string_view("SHOW"), ResultSetType::Select },
        std::pair{ std::string_view("INSERT"), ResultSetType::Update },
        std::pair{ std::string_view("UPDATE"), ResultSetType::Update },
        std::pair{ std::string_view("DELETE"), ResultSetType::Update },
        std::pair{ std::string_view("REPLACE"), ResultSetType::Update },
        std::pair{ std::string_view("CREATE"), ResultSetType::Update },
        std::pair{ std::string_view("ALTER"), ResultSetType::Update },
        std::pair{ std::string_view("DROP"), ResultSetType::Update },
        std::pair{ std::string_view("TRUNCATE"), ResultSetType::Update },
        std::pair{ std::string_view("SET"), ResultSetType::Update },
        std::pair{ std::string_view("START"), ResultSetType::Update },
        std::pair{ std::string_view("COMMIT"), ResultSetType::Update },
        std::pair{ std::string_view("ROLLBACK"), ResultSetType::Update },
    };

    const auto start = query.find_first_not_of(whitespace);
    if (start == std::string_view::npos)
    {
        return ResultSetType::Invalid;
    }

    query.remove_prefix(start);

    const auto keywordEnd = std::ranges::find_if_not(query, isWordCharacter);
    const auto keyword    = std::string_view(query.begin(), keywordEnd);

    for (const auto& [name, type] : keywords)
    {
        const auto matches = std::ranges::equal(
            name,
            keyword,
            [](const char upper, const char c)
            {
                return upper == toUpperASCII(c);
            });

        if (matches)
        {
            return type;
        }
    }

    return ResultSetType::Invalid;
}

// Reject stray "{}" format holes, and ';', which would chain a second statement.
// '%' stays legal because it's the LIKE wildcard.
[[nodiscard]] constexpr auto validateQueryContent(const std::string_view query) -> bool
{
    return !query.contains("{}") && !query.contains(';');
}

// The server binds parameters to every '?' outside quoted text.
[[nodiscard]] constexpr auto countPlaceholders(const std::string_view text) noexcept -> std::size_t
{
    auto count = std::size_t{ 0 };
    auto quote = '\0';
    for (auto i = std::size_t{ 0 }; i < text.size(); ++i)
    {
        const auto c = text[i];
        if (quote != '\0')
        {
            if (c == '\\')
            {
                ++i;
            }
            else if (c == quote)
            {
                quote = '\0';
            }
        }
        else if (c == '\'' || c == '"' || c == '`')
        {
            quote = c;
        }
        else if (c == '?')
        {
            ++count;
        }
    }

    return count;
}

} // namespace db::detail
