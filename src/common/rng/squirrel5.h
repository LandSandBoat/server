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

// ATTR: Squirrel Eiserloh https://www.gdcvault.com/play/1024365/Math-for-Game-Programmers-Noise
// Original Source: http://eiserloh.net/noise/SquirrelNoise5.hpp
class Squirrel5
{
public:
    using result_type = uint32_t;

    static constexpr result_type min()
    {
        return 0;
    }

    static constexpr result_type max()
    {
        return std::numeric_limits<result_type>::max();
    }

    Squirrel5(result_type seed_val = 0)
    : m_seed(seed_val)
    {
    }

    void seed(result_type seed_val)
    {
        m_seed     = seed_val;
        m_position = 0;
    }

    template <class Sseq>
    void seed(Sseq& seq)
    {
        std::array<uint32_t, 1> buf;
        seq.generate(buf.begin(), buf.end());
        m_seed     = buf[0];
        m_position = 0;
    }

    result_type operator()()
    {
        return noise(m_position++, m_seed);
    }

    static uint32_t noise(int32_t position, uint32_t seed)
    {
        constexpr uint32_t SQ5_BIT_NOISE1 = 0xd2a80a3f; // 11010010101010000000101000111111
        constexpr uint32_t SQ5_BIT_NOISE2 = 0xa884f197; // 10101000100001001111000110010111
        constexpr uint32_t SQ5_BIT_NOISE3 = 0x6C736F4B; // 01101100011100110110111101001011
        constexpr uint32_t SQ5_BIT_NOISE4 = 0xB79F3ABB; // 10110111100111110011101010111011
        constexpr uint32_t SQ5_BIT_NOISE5 = 0x1b56c4f5; // 00011011010101101100010011110101

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

private:
    uint32_t m_seed     = 0;
    uint32_t m_position = 0;
};
