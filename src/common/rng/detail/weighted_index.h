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

#include <common/rng/detail/canonical_float.h>

#include <cstddef>
#include <random>
#include <span>

namespace xirand::detail
{

// Portable weighted index selection. Replaces std::discrete_distribution, whose
// construction and sampling are implementation-defined and diverge across
// standard libraries. Picks index i with probability weights[i] / sum(weights),
// matching std::discrete_distribution's semantics (zero-weight entries are never
// selected; negative weights are undefined, as in the standard).
//
// ATTR: Inverse transform sampling over the cumulative distribution, a.k.a.
//       roulette-wheel / fitness-proportionate selection.
//       https://en.wikipedia.org/wiki/Inverse_transform_sampling
//       https://en.wikipedia.org/wiki/Fitness_proportionate_selection
//
/// @param g       A 32-bit uniform random bit generator (e.g. Squirrel5).
/// @param weights Span of non-negative weights.
/// @return Index in [0, weights.size()); 0 if empty or total weight is zero.
template <std::uniform_random_bit_generator G>
[[nodiscard]] constexpr auto weightedIndex(G& g, std::span<const double> weights) -> size_t;

} // namespace xirand::detail

template <std::uniform_random_bit_generator G>
[[nodiscard]] constexpr auto xirand::detail::weightedIndex(G& g, std::span<const double> weights) -> size_t
{
    if (weights.empty())
    {
        return 0;
    }

    double total = 0.0;
    for (const double w : weights)
    {
        total += w;
    }

    if (total <= 0.0)
    {
        return 0;
    }

    // Draw a point in [0, total) and walk the cumulative weights.
    const double target     = canonical53(g) * total;
    double       cumulative = 0.0;
    for (size_t i = 0; i < weights.size(); ++i)
    {
        cumulative += weights[i];
        if (target < cumulative)
        {
            return i;
        }
    }

    // Defensive fallback. Effectively unreachable: `cumulative` sums the weights in
    // the same order as `total`, so after the final element cumulative == total exactly,
    // and target = canonical53() * total < total, so the loop always returns first.
    return weights.size() - 1;
}
