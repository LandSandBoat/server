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
#include <common/database/traits.h>

#include <cstddef>
#include <string>
#include <string_view>
#include <tuple>
#include <type_traits>

namespace db
{

// Marker for query text only known at runtime (fmt-built IN lists, validated column names).
// Skips compile-time validation; the layer still validates the text when the statement is
// first prepared.
struct RuntimeQuery
{
    std::string_view text;
};

[[nodiscard]] constexpr auto runtime(std::string_view text) noexcept -> RuntimeQuery
{
    return RuntimeQuery{ text };
}

namespace detail
{

// Count the '?' bind placeholders in a query, ignoring any inside quoted regions.
[[nodiscard]] constexpr auto countPlaceholders(std::string_view query) noexcept -> std::size_t
{
    std::size_t count = 0;
    char        quote = '\0';

    for (std::size_t i = 0; i < query.size(); ++i)
    {
        const char c = query[i];

        if (quote != '\0')
        {
            if (c == '\\')
            {
                ++i; // Skip the escaped character.
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

// Diagnostic anchors. These are declared but never defined: calling one from the consteval
// constructor below is ill-formed in a constant expression, so compilation fails with the
// function's name in the error message, saying what is wrong with the query.
auto error_InvalidLeadingSqlKeyword() -> void;
auto error_QueryContainsForbiddenCharacters() -> void;
auto error_PlaceholderCountDoesNotMatchArgumentCount() -> void;

// A vector argument expands to one bound parameter per element, so the placeholder count for a
// query taking one cannot be checked at compile time.
template <typename T>
inline constexpr bool is_dynamic_placeholder_arg_v = is_std_vector_v<std::remove_cvref_t<T>>;

} // namespace detail

// A query string that validates itself at compile time when built from a string literal.
//
// A string literal binds the consteval constructor, which checks, at compile time: the leading SQL
// keyword, the absence of forbidden characters (';', stray "{}" format holes), and - unless an
// argument is a vector, whose element count is dynamic - that the '?' placeholder count matches the
// bound-argument count. A bad literal fails to compile.
//
// Runtime-built text (fmt-assembled IN lists, validated column names) binds the string_view
// constructor instead, which does no compile-time check; the layer still validates and classifies
// it when the statement is first prepared. Wrapping such text in db::runtime(...) is optional and
// serves only to flag the dynamic query for a reader.
template <typename... Args>
class QueryString
{
public:
    // String literals (and char arrays) - validated at compile time.
    template <std::size_t N>
    consteval QueryString(const char (&literal)[N]) // NOLINT(google-explicit-constructor)
    : text_(literal, N - 1)
    {
        if (detail::validateQueryLeadingKeyword(text_) == ResultSetType::Invalid)
        {
            detail::error_InvalidLeadingSqlKeyword();
        }

        if (!detail::validateQueryContent(text_))
        {
            detail::error_QueryContainsForbiddenCharacters();
        }

        // A vector argument expands to a runtime number of bound parameters, so the count can only
        // be checked when every argument is a single, statically-known parameter.
        if constexpr (!(detail::is_dynamic_placeholder_arg_v<Args> || ...))
        {
            if (detail::countPlaceholders(text_) != sizeof...(Args))
            {
                detail::error_PlaceholderCountDoesNotMatchArgumentCount();
            }
        }
    }

    // Runtime-built query text - not checked here; validated at prepare time. A const char*
    // needs its own constructor: reaching the string_view one would take two user-defined
    // conversions, which the language does not apply implicitly.
    constexpr QueryString(std::string_view query) noexcept // NOLINT(google-explicit-constructor)
    : text_(query)
    {
    }

    constexpr QueryString(const char* query) noexcept // NOLINT(google-explicit-constructor)
    : text_(query)
    {
    }

    constexpr QueryString(const std::string& query) noexcept // NOLINT(google-explicit-constructor)
    : text_(query)
    {
    }

    constexpr QueryString(RuntimeQuery query) noexcept // NOLINT(google-explicit-constructor)
    : text_(query.text)
    {
    }

    [[nodiscard]] constexpr auto text() const noexcept -> std::string_view
    {
        return text_;
    }

private:
    std::string_view text_;
};

namespace detail
{

// The tuple db::executeBulk's projection yields for one row: one element per placeholder.
template <typename T, typename ProjectFn>
using BulkRow = std::remove_cvref_t<std::invoke_result_t<ProjectFn, const T&>>;

template <typename Row>
struct QueryStringForRow;

template <typename... Ts>
struct QueryStringForRow<std::tuple<Ts...>>
{
    using type = QueryString<Ts...>;
};

// db::executeBulk takes its placeholder count from the projected row rather than from a bound
// argument pack, so its query validates against that tuple instead.
template <typename T, typename ProjectFn>
using BulkQueryString = typename QueryStringForRow<BulkRow<T, ProjectFn>>::type;

} // namespace detail

} // namespace db
