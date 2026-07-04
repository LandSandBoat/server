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

#include <cstdint>
#include <random>

namespace xirand::detail
{

// Portable canonical value in [0, 1), built from a fixed 53 engine bits / 2^53.
// Replaces std::uniform_real_distribution / std::generate_canonical, both of
// which are implementation-defined and diverge across standard libraries.
//
// ATTR: The (a >> 5) * 2^26 + (b >> 6), all over 2^53 construction is the
//       genrand_res53() routine from Matsumoto & Nishimura's Mersenne Twister
//       reference implementation, and is the same formula NumPy uses for
//       random_double().
//       MT reference: http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/MT2002/CODES/mt19937ar.c
//       NumPy:        https://github.com/numpy/numpy/blob/main/numpy/random/src/distributions/random_mtrand.c
//
/// @param g A 32-bit uniform random bit generator (e.g. Squirrel5).
/// @return A double in [0, 1).
template <std::uniform_random_bit_generator G>
[[nodiscard]] constexpr auto canonical53(G& g) -> double;

} // namespace xirand::detail

template <std::uniform_random_bit_generator G>
[[nodiscard]] constexpr auto xirand::detail::canonical53(G& g) -> double
{
    // This helper consumes one 32-bit word per draw; a narrower engine can't feed it.
    static_assert(sizeof(typename G::result_type) >= sizeof(uint32_t), "canonical53 requires a >= 32-bit engine");

    const uint64_t hi = static_cast<uint32_t>(g()) >> 5; // top 27 bits
    const uint64_t lo = static_cast<uint32_t>(g()) >> 6; // top 26 bits
    // (hi * 2^26 + lo) / 2^53  ->  [0, 1)
    return (static_cast<double>(hi) * 67108864.0 + static_cast<double>(lo)) * (1.0 / 9007199254740992.0);
}
