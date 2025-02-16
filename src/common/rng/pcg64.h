/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

// https://github.com/imneme/pcg-cpp
#include "pcg_random.hpp"

#include <array>
#include <random>

// Forward declare sysrandom which is built in the xirand.h/cpp compilation unit
extern size_t sysrandom(void* dst, size_t dstlen);

class xirand
{
public:
    static pcg64& rng()
    {
        static thread_local pcg64 e{};
        return e;
    }

    static void seed()
    {
        ShowInfo("Seeding PCG64 RNG");

        std::array<pcg64::state_type, 2> seed_data;

        pcg64::state_type seed;

        for (auto it = seed_data.begin(); it != seed_data.end(); ++it)
        {
            sysrandom(&seed, sizeof(seed));

            *it = seed;
        }

        std::seed_seq seq(seed_data.cbegin(), seed_data.cend());
        rng().seed(seq);
    }

    //
    // Declarations for RNG methods implemented in xirand.h.
    //

    template <typename T>
    static inline typename std::enable_if<std::is_integral<T>::value, T>::type GetRandomNumber(T min, T max);

    template <typename T>
    static inline typename std::enable_if<std::is_floating_point<T>::value, T>::type GetRandomNumber(T min, T max);

    template <typename T>
    static inline T GetRandomNumber(T max);

    template <typename T>
    static inline typename T::value_type GetRandomElement(T* container);

    template <typename T>
    static inline typename T::value_type GetRandomElement(T& container);

    template <typename T>
    static inline T GetRandomElement(std::initializer_list<T> list);
};
