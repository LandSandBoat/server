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

#include <cassert>
#include <cstdint>
#include <random>

namespace xirand::detail
{

// Lemire's unbiased bounded-integer method. Deterministic and identical on
// every platform, unlike std::uniform_int_distribution whose bit-consumption
// algorithm is implementation-defined (libc++, libstdc++, and MSVC STL each
// map the same engine bits to different integers).
//
// ATTR: Daniel Lemire, "Fast Random Integer Generation in an Interval"
//       Paper:     https://arxiv.org/abs/1805.10941
//       Blog:      https://lemire.me/blog/2016/06/30/fast-random-shuffling/
//       Reference: https://github.com/lemire/fastrange
//       The same widening-multiply-with-rejection method is used by Rust's
//       `rand` crate (UniformInt::sample_single):
//       https://github.com/rust-random/rand/blob/master/src/distr/uniform_int.rs
//
/// @param g     A 32-bit uniform random bit generator (e.g. Squirrel5).
/// @param count Number of distinct outcomes; result is in [0, count). Must be >= 1.
/// @return A value in [0, count).
/// @note Covers counts up to 2^32 (any range used in this codebase). Larger
///       ranges would silently truncate to [0, 2^32) and would require a 64-bit
///       variant; the debug assert below fails loudly if one is ever requested.
template <std::uniform_random_bit_generator G>
[[nodiscard]] constexpr auto bounded32(G& g, uint64_t count) -> uint32_t;

} // namespace xirand::detail

template <std::uniform_random_bit_generator G>
[[nodiscard]] constexpr auto xirand::detail::bounded32(G& g, uint64_t count) -> uint32_t
{
    // This helper consumes one 32-bit word per draw; a narrower engine can't feed it.
    static_assert(sizeof(typename G::result_type) >= sizeof(uint32_t), "bounded32 requires a >= 32-bit engine");

    assert(count <= (uint64_t{ 1 } << 32)); // larger ranges truncate; a 64-bit variant would be needed
    if (count >= (uint64_t{ 1 } << 32))
    {
        return static_cast<uint32_t>(g()); // exactly 2^32 -> full 32-bit span
    }

    const uint32_t range = static_cast<uint32_t>(count);

    uint32_t x   = static_cast<uint32_t>(g());
    uint64_t m   = static_cast<uint64_t>(x) * range;
    uint32_t low = static_cast<uint32_t>(m);
    if (low < range)
    {
        const uint32_t threshold = (0u - range) % range; // 2^32 % range
        while (low < threshold)
        {
            x   = static_cast<uint32_t>(g());
            m   = static_cast<uint64_t>(x) * range;
            low = static_cast<uint32_t>(m);
        }
    }
    return static_cast<uint32_t>(m >> 32);
}
