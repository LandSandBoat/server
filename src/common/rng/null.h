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
#include <random>

//
// Forward declare sysrandom which is built in the xirand.h/cpp compilation unit
//

extern size_t sysrandom(void* dst, size_t dstlen);

class NullRandomEngine
{
public:
    using result_type = uint64_t;

    static constexpr result_type min()
    {
        return 0;
    }

    static constexpr result_type max()
    {
        return std::numeric_limits<result_type>::max();
    }

    result_type operator()()
    {
        return (min() + max()) / 2;
    }

    void seed(result_type)
    {
    }
};

class xirand
{
public:
    static NullRandomEngine& rng()
    {
        static thread_local NullRandomEngine e{};
        return e;
    }

    static void seed()
    {
        ShowInfo("Seeding Null Random Engine (does nothing)");

        rng().seed(42);
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
