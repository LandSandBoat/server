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

#include <common/rng/detail/bounded_int.h>

#include <algorithm>
#include <cstdint>
#include <iterator>
#include <random>

namespace xirand::detail
{

// Portable in-place shuffle. Replaces std::shuffle, whose index generation is
// unspecified by the standard: each implementation drives it with an internal
// uniform_int_distribution-equivalent and so produces a different permutation
// from identical engine bits. Building the swap indices from detail::bounded32
// makes the result deterministic and identical on every platform.
//
// ATTR: Fisher-Yates shuffle (Durstenfeld's in-place variant).
//       https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
//
/// @param first First iterator of the range to shuffle.
/// @param last  One-past-the-end iterator of the range to shuffle.
/// @param g     A 32-bit uniform random bit generator (e.g. Squirrel5).
template <std::uniform_random_bit_generator G, std::random_access_iterator It>
constexpr auto shuffle(It first, It last, G& g) -> void;

} // namespace xirand::detail

template <std::uniform_random_bit_generator G, std::random_access_iterator It>
constexpr auto xirand::detail::shuffle(It first, It last, G& g) -> void
{
    using diff_t = std::iter_difference_t<It>;

    // Walk from the back, swapping element i with a uniformly chosen j in [0, i].
    for (diff_t i = (last - first) - 1; i > 0; --i)
    {
        const diff_t j = static_cast<diff_t>(bounded32(g, static_cast<uint64_t>(i) + 1));
        std::iter_swap(first + i, first + j);
    }
}
