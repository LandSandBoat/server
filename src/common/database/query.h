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

#include <cstddef>
#include <string_view>

namespace db
{

// Only a string literal converts to a Query, so statement text can never come from runtime values.
class Query final
{
public:
    template <std::size_t N>
    consteval Query(const char (&text)[N]) noexcept
    : text_(text, N - 1)
    , placeholders_(countPlaceholders(text_))
    {
    }

    [[nodiscard]] constexpr auto view() const noexcept -> std::string_view
    {
        return text_;
    }

    [[nodiscard]] constexpr auto placeholders() const noexcept -> std::size_t
    {
        return placeholders_;
    }

private:
    // The server binds parameters to every '?' outside quoted text.
    static consteval auto countPlaceholders(const std::string_view text) noexcept -> std::size_t
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

    std::string_view text_;
    std::size_t      placeholders_;
};

[[nodiscard]] constexpr auto format_as(const Query query) noexcept -> std::string_view
{
    return query.view();
}

} // namespace db
