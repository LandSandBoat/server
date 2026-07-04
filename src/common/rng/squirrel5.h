/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <array>
#include <cstdint>
#include <limits>
#include <type_traits>

template <typename T>
concept SeedSequence = !std::is_arithmetic_v<T>;

// ATTR: Squirrel Eiserloh https://www.gdcvault.com/play/1024365/Math-for-Game-Programmers-Noise
// Original Source: http://eiserloh.net/noise/SquirrelNoise5.hpp
class Squirrel5
{
public:
    using result_type = uint32_t;

    static constexpr auto min() -> result_type;
    static constexpr auto max() -> result_type;

    constexpr Squirrel5(result_type seed_val = 0);

    constexpr auto seed(result_type seed_val) -> void;

    template <SeedSequence Sseq>
    constexpr auto seed(Sseq& seq) -> void;

    constexpr auto operator()() -> result_type;

    static constexpr auto noise(int32_t position, uint32_t seed) -> uint32_t;

private:
    uint32_t m_seed     = 0;
    uint32_t m_position = 0;
};

constexpr auto Squirrel5::min() -> result_type
{
    return 0;
}

constexpr auto Squirrel5::max() -> result_type
{
    return std::numeric_limits<result_type>::max();
}

constexpr Squirrel5::Squirrel5(result_type seed_val)
: m_seed(seed_val)
{
}

constexpr auto Squirrel5::seed(result_type seed_val) -> void
{
    m_seed     = seed_val;
    m_position = 0;
}

template <SeedSequence Sseq>
constexpr auto Squirrel5::seed(Sseq& seq) -> void
{
    std::array<uint32_t, 1> buf;
    seq.generate(buf.begin(), buf.end());
    m_seed     = buf[0];
    m_position = 0;
}

constexpr auto Squirrel5::operator()() -> result_type
{
    return noise(m_position++, m_seed);
}

constexpr auto Squirrel5::noise(int32_t position, uint32_t seed) -> uint32_t
{
    constexpr uint32_t SQ5_BIT_NOISE1 = 0xD2A80A3F; // 11010010101010000000101000111111
    constexpr uint32_t SQ5_BIT_NOISE2 = 0xA884F197; // 10101000100001001111000110010111
    constexpr uint32_t SQ5_BIT_NOISE3 = 0x6C736F4B; // 01101100011100110110111101001011
    constexpr uint32_t SQ5_BIT_NOISE4 = 0xB79F3ABB; // 10110111100111110011101010111011
    constexpr uint32_t SQ5_BIT_NOISE5 = 0x1B56C4F5; // 00011011010101101100010011110101

    uint32_t mangled = static_cast<uint32_t>(position);
    mangled *= SQ5_BIT_NOISE1;
    mangled += seed;
    mangled ^= (mangled >> 9);
    mangled += SQ5_BIT_NOISE2;
    mangled ^= (mangled >> 11);
    mangled *= SQ5_BIT_NOISE3;
    mangled ^= (mangled >> 13);
    mangled += SQ5_BIT_NOISE4;
    mangled ^= (mangled >> 15);
    mangled *= SQ5_BIT_NOISE5;
    mangled ^= (mangled >> 17);
    return mangled;
}
