/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams
  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include <algorithm>
#include <concepts>
#include <initializer_list>
#include <limits>
#include <random>
#include <ranges>
#include <span>
#include <stdexcept>
#include <type_traits>

#include <common/rng/detail/bounded_int.h>
#include <common/rng/detail/canonical_float.h>
#include <common/rng/detail/normal.h>
#include <common/rng/detail/shuffle.h>
#include <common/rng/detail/weighted_index.h>

//
// @brief Random Engine Selection
//
// Define one of the following macros to select a specific RNG engine.
// If none are defined, Squirrel5 is used by default.
//
// - XIRAND_PCG64
// - XIRAND_PCG32
// - XIRAND_MT32
// - XIRAND_MT64
// - XIRAND_SQUIRREL5
// - XIRAND_NULL
//

#if defined(XIRAND_PCG64)
#include <pcg_random.hpp>
using SelectedRandomEngine = pcg64;
#elif defined(XIRAND_PCG32)
#include <pcg_random.hpp>
using SelectedRandomEngine = pcg32;
#elif defined(XIRAND_MT32)
using SelectedRandomEngine = std::mt19937;
#elif defined(XIRAND_SQUIRREL5)
#include <common/rng/squirrel5.h>
using SelectedRandomEngine = Squirrel5;
#elif defined(XIRAND_NULL)
#include <common/rng/null.h>
using SelectedRandomEngine = NullRandomEngine;
#else // Default
#include <common/rng/squirrel5.h>
using SelectedRandomEngine = Squirrel5;
#endif

static_assert(std::uniform_random_bit_generator<SelectedRandomEngine>, "SelectedRandomEngine must satisfy the UniformRandomBitGenerator concept");
static_assert(std::is_default_constructible_v<SelectedRandomEngine>, "SelectedRandomEngine must be default constructible");

/// @brief Cross-platform implementation of secure random numbers for seeding.
auto sysrandom(void* dst, size_t dstlen) -> size_t;

namespace xirand
{

/// @brief Accessor for the thread-local engine. It is guaranteed to be correctly seeded.
[[nodiscard]] auto rng() -> SelectedRandomEngine&;

/// @brief Manually seed the thread-local RNG.
/// @note Calls to rng() will automatically call seed(). You don't need to do this manually.
///       We _do_ manually call this in xi_test to force different seeds.
void seed();

/// @brief Generates a random number in the half-open interval [min, max).
/// @tparam T Integer type.
/// @param min Minimum value (inclusive).
/// @param max Maximum value (exclusive).
/// @return Random value in [min, max).
/// @note Both the integer and real overloads are half-open [min, max) by construction
///       (detail::bounded32 / detail::canonical53), so they share the same min/max range.
///       This no longer relies on std::uniform_int_distribution's closed-interval
///       convention (linked issue, the source of the old workaround:
///       https://bugs.llvm.org/show_bug.cgi?id=18767#c1).
template <std::integral T>
[[nodiscard]] inline auto GetRandomNumber(T min, T max) -> T;

template <std::floating_point T>
[[nodiscard]] inline auto GetRandomNumber(T min, T max) -> T;

/// @brief Generates a random number in the half-open interval [0, max).
/// @tparam T Number type.
/// @param max Maximum value (exclusive).
/// @return Random value in [0, max).
template <typename T>
[[nodiscard]] inline auto GetRandomNumber(T max) -> T;

/// @brief Generates a normally distributed random number.
/// @param mean Mean of the distribution.
/// @param stddev Standard deviation; values <= 0 collapse the distribution to mean.
/// @return Normally distributed value.
/// @note Inverse-transform sampling (detail::inverseNormalCDF): exactly one engine
///       draw per sample regardless of arguments, so seeded streams stay aligned.
///       Results are capped at ~8.2 sigma by construction. Unlike the uniform
///       helpers, values may differ in the last few ulps across platforms
///       (std::log/exp/erfc are libm-dependent).
[[nodiscard]] inline auto GetNormalNumber(double mean, double stddev) -> double;

/// @brief Generates a normally distributed random number truncated to [lower, upper].
/// @return Value in [lower, upper]; lower if the interval is empty.
/// @note Exact truncated normal: the uniform draw is mapped into the CDF mass
///       between the bounds, so there are no rejection loops, no redraw caps, and
///       no probability spikes at the bounds. Still exactly one engine draw.
[[nodiscard]] inline auto GetNormalNumber(double mean, double stddev, double lower, double upper) -> double;

/// @brief Gets a random element from the given random_access_range (e.g. vector, array, deque).
/// @tparam R Random access range type.
/// @param range The container or range.
/// @return Copy of the randomly selected element (or value-initialized T if empty).
/// @throws std::out_of_range if the range is empty and T is not default constructible.
template <std::ranges::random_access_range R>
[[nodiscard]] inline auto GetRandomElement(R&& range) -> std::ranges::range_value_t<R>;

/// @brief Returns a random index based on weights.
/// @param weights Span of weights.
/// @return Index of the selected weight.
[[nodiscard]] inline auto GetWeightedIndex(std::span<const double> weights) -> size_t;

/// @brief Returns a random index based on weights.
/// @param weights Initializer list of weights.
/// @return Index of the selected weight.
/// @example GetWeightedIndex({70, 20, 10}) has a 70% chance to return 0.
[[nodiscard]] inline auto GetWeightedIndex(std::initializer_list<double> weights) -> size_t;

/// @brief Returns a random element from a map of <Element, Weight>.
/// @tparam Container Map-like container type.
/// @param table Map of elements to weights.
/// @return Key of the selected element.
/// @example GetWeightedElement(std::map<std::string, double>{{"Common", 70}, {"Rare", 30}})
/// @throws std::out_of_range if the table is empty and key_type is not default constructible.
template <typename Container>
[[nodiscard]] inline auto GetWeightedElement(const Container& table) -> typename Container::key_type;

/// @brief Shuffles a random_access_range in place using the thread-local engine.
/// @tparam R Random access range type.
/// @param range The container or range to shuffle.
template <std::ranges::random_access_range R>
inline auto ShuffleInPlace(R&& range) -> void;

} // namespace xirand

//
// inline impls
//

template <std::integral T>
[[nodiscard]] inline auto xirand::GetRandomNumber(T min, T max) -> T
{
    if (min >= max)
    {
        return min;
    }

    // Compute the outcome count in U's own modulus. The extra cast back to U matters
    // for types narrower than int: `U(max) - U(min)` would otherwise promote to int and,
    // for a negative min, widen to a bogus huge count. Keeping it in U wraps correctly.
    using U       = std::make_unsigned_t<T>;
    const U count = static_cast<U>(static_cast<U>(max) - static_cast<U>(min));
    return static_cast<T>(static_cast<U>(min) + detail::bounded32(rng(), count));
}

template <std::floating_point T>
[[nodiscard]] inline auto xirand::GetRandomNumber(T min, T max) -> T
{
    if (min >= max)
    {
        return min;
    }

    // scaleCanonical guards the rounding edge where the scaled draw lands exactly on
    // max (most likely when narrowing to float), keeping the [min, max) contract honest.
    return detail::scaleCanonical(detail::canonical53(rng()), min, max);
}

template <typename T>
[[nodiscard]] inline auto xirand::GetRandomNumber(T max) -> T
{
    return GetRandomNumber<T>(0, max);
}

[[nodiscard]] inline auto xirand::GetNormalNumber(const double mean, const double stddev) -> double
{
    constexpr double inf = std::numeric_limits<double>::infinity();
    return GetNormalNumber(mean, stddev, -inf, inf);
}

[[nodiscard]] inline auto xirand::GetNormalNumber(const double mean, const double stddev, const double lower, const double upper) -> double
{
    if (lower >= upper)
    {
        return lower;
    }

    if (!(stddev > 0.0)) // <= 0 or NaN: no spread.
    {
        return std::clamp(mean, lower, upper);
    }

    // CDF mass below each bound; 0 and 1 for infinite bounds.
    const double pLo = detail::normalCDF((lower - mean) / stddev);
    const double pHi = detail::normalCDF((upper - mean) / stddev);

    // Map the draw into the mass between the bounds, keeping clear of the CDF
    // endpoints where the inverse is singular (this caps results at ~8.2 sigma).
    const double unit = detail::canonical53(rng());
    const double p    = std::clamp(pLo + unit * (pHi - pLo), 0x1p-53, detail::nextDown(1.0));

    // The final clamp only guards approximation edges right at the bounds.
    return std::clamp(mean + stddev * detail::inverseNormalCDF(p), lower, upper);
}

template <std::ranges::random_access_range R>
[[nodiscard]] inline auto xirand::GetRandomElement(R&& range) -> std::ranges::range_value_t<R>
{
    if (std::ranges::empty(range))
    {
        if constexpr (std::is_default_constructible_v<std::ranges::range_value_t<R>>)
        {
            return {};
        }
        else
        {
            throw std::out_of_range("GetRandomElement called on empty container with non-default-constructible type");
        }
    }

    auto index = GetRandomNumber<std::ranges::range_size_t<R>>(0, std::ranges::size(range));
    return range[index];
}

[[nodiscard]] inline auto xirand::GetWeightedIndex(std::span<const double> weights) -> size_t
{
    return detail::weightedIndex(rng(), weights);
}

[[nodiscard]] inline auto xirand::GetWeightedIndex(std::initializer_list<double> weights) -> size_t
{
    return GetWeightedIndex(std::span<const double>(weights));
}

template <typename Container>
[[nodiscard]] inline auto xirand::GetWeightedElement(const Container& table) -> typename Container::key_type
{
    if (table.empty())
    {
        if constexpr (std::is_default_constructible_v<typename Container::key_type>)
        {
            return {};
        }
        else
        {
            throw std::out_of_range("GetWeightedElement called on empty container with non-default-constructible type");
        }
    }

    std::vector<double>                       weights;
    std::vector<typename Container::key_type> elements;
    weights.reserve(table.size());
    elements.reserve(table.size());

    for (const auto& [item, weight] : table)
    {
        elements.push_back(item);
        weights.push_back(static_cast<double>(weight));
    }

    return elements[detail::weightedIndex(rng(), std::span<const double>(weights))];
}

template <std::ranges::random_access_range R>
inline auto xirand::ShuffleInPlace(R&& range) -> void
{
    detail::shuffle(std::ranges::begin(range), std::ranges::end(range), rng());
}
