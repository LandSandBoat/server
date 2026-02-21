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
#include <iterator>
#include <map>
#include <random>
#include <ranges>
#include <span>
#include <stdexcept>
#include <type_traits>
#include <vector>

//
// @brief Random Engine Selection
//
// Define one of the following macros to select a specific RNG engine.
// If none are defined, XIRAND_MT64 (std::mt19937_64) is used by default.
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
#include "rng/squirrel5.h"
using SelectedRandomEngine = Squirrel5;
#elif defined(XIRAND_NULL)
#include "rng/null.h"
using SelectedRandomEngine = NullRandomEngine;
#else
using SelectedRandomEngine = std::mt19937_64;
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
/// @note max is subtracted by one as per an inconsistency in the standard, see
///       https://bugs.llvm.org/show_bug.cgi?id=18767#c1
///       This change results in both real and integer templates having the same min/max range.
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
[[nodiscard]] inline auto GetWeightedElement(Container const& table) -> typename Container::key_type;
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

    std::uniform_int_distribution<T> dist(min, max - 1);
    return dist(rng());
}

template <std::floating_point T>
[[nodiscard]] inline auto xirand::GetRandomNumber(T min, T max) -> T
{
    if (min >= max)
    {
        return min;
    }

    std::uniform_real_distribution<T> dist(min, max);
    return dist(rng());
}

template <typename T>
[[nodiscard]] inline auto xirand::GetRandomNumber(T max) -> T
{
    return GetRandomNumber<T>(0, max);
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
    if (weights.empty())
    {
        return 0;
    }

    std::discrete_distribution<size_t> dist(weights.begin(), weights.end());
    return dist(rng());
}

[[nodiscard]] inline auto xirand::GetWeightedIndex(std::initializer_list<double> weights) -> size_t
{
    return GetWeightedIndex(std::span<const double>(weights));
}

template <typename Container>
[[nodiscard]] inline auto xirand::GetWeightedElement(Container const& table) -> typename Container::key_type
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

    for (auto const& [item, weight] : table)
    {
        elements.push_back(item);
        weights.push_back(static_cast<double>(weight));
    }

    std::discrete_distribution<size_t> dist(weights.begin(), weights.end());
    return elements[dist(rng())];
}
