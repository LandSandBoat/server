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

#include <common/database/query_validation.h>

#include <cstddef>
#include <string_view>

namespace db
{

// Only a string literal converts to a Query, and the text is validated as it compiles.
class Query final
{
public:
    template <std::size_t N>
    consteval Query(const char (&text)[N])
    : text_(text, N - 1)
    , placeholders_(detail::countPlaceholders(text_))
    , type_(detail::validateQueryLeadingKeyword(text_))
    {
        if (type_ == ResultSetType::Invalid)
        {
            throw "A query must start with a known keyword, such as SELECT or UPDATE";
        }

        if (!detail::validateQueryContent(text_))
        {
            throw "A query can't contain ';' or '{}'";
        }
    }

    [[nodiscard]] constexpr auto view() const noexcept -> std::string_view
    {
        return text_;
    }

    [[nodiscard]] constexpr auto placeholders() const noexcept -> std::size_t
    {
        return placeholders_;
    }

    [[nodiscard]] constexpr auto type() const noexcept -> ResultSetType
    {
        return type_;
    }

private:
    std::string_view text_;
    std::size_t      placeholders_;
    ResultSetType    type_;
};

[[nodiscard]] constexpr auto format_as(const Query query) noexcept -> std::string_view
{
    return query.view();
}

namespace detail
{

struct SelectedQuery
{
    Query query;
};

} // namespace detail

// Marks a query picked at runtime, such as from a table, so its argument count is checked when it runs.
[[nodiscard]] constexpr auto selected(const Query query) noexcept -> detail::SelectedQuery
{
    return detail::SelectedQuery{ query };
}

} // namespace db
