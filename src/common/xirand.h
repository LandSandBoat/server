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

#ifndef _XIRAND_H_
#define _XIRAND_H_

//
// You can choose an RNG by commenting/uncommenting one of the lines below.
// The default is Mersenne Twister in 64 bit.
//

// TODO: Make these selectable with #ifdef build flags

// #include "rng/null.h"
// #include "rng/mersennetwister.h"
#include "rng/mersennetwister64.h"
// #include "rng/pcg.h"
// #include "rng/pcg64.h"

// RNG template is as follows:
// The RNG must comply with the CPP standard UniformRandomBitGenerator ( see https://en.cppreference.com/w/cpp/named_req/UniformRandomBitGenerator )
//
// The RNG must return a static thread local instance of the RNG with "rng()" as the accessor, such as:
// static std::mt19937& rng()
//
// The RNG must have a seed function declared as follows:
//
// static void seed()
//
// The RNG must have the following boilerplate templated function declarations
/*
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
*/
// See the latest revision of src/common/RNG/mersennetwister.h for an example.

//
// The following functions are not meant to be edited by the end user. Change at your own risk -- you will receive no support.
//

// Generates a random number in the half-open interval [min, max)
// @param min
// @param max
// @returns result
//
// Do note that max is subtracted by one as per an inconsistency in the standard, see
// https://bugs.llvm.org/show_bug.cgi?id=18767#c1
// this change results in both real and integer templates having the same min/max range
template <typename T>
inline typename std::enable_if<std::is_integral<T>::value, T>::type xirand::GetRandomNumber(T min, T max)
{
    if (min == max - 1 || max == min || min > max)
    {
        return min;
    }
    std::uniform_int_distribution<T> dist(min, max - 1);
    return dist(rng());
}

template <typename T>
inline typename std::enable_if<std::is_floating_point<T>::value, T>::type xirand::GetRandomNumber(T min, T max)
{
    if (min >= max)
    {
        return min;
    }
    std::uniform_real_distribution<T> dist(min, max);
    return dist(rng());
}

// Generates a random number in the half-open interval [0, max)
// @param min
// @param max
// @returns result
//
// Do note that max is subtracted by one as per an inconsistency in the standard, see
// https://bugs.llvm.org/show_bug.cgi?id=18767#c1
// this change results in both real and integer templates having the same min/max range
template <typename T>
inline T xirand::GetRandomNumber(T max)
{
    return GetRandomNumber<T>(0, max);
}

// Gets a random element from the given stl-like container (container must have members: at() and size()).
// @param container
// @returns result
template <typename T>
inline typename T::value_type xirand::GetRandomElement(T* container)
{
    // NOTE: the specialisation for integral types uses: dist(min, max - 1), so no need to offset container->size()
    return container->at(GetRandomNumber<std::size_t>(0U, container->size()));
}

// Gets a random element from the given stl-like container (container must have members: at() and size()).
// @param container
// @returns result
template <typename T>
inline typename T::value_type xirand::GetRandomElement(T& container)
{
    return GetRandomElement(&container);
}

// Gets a random element from the given initializer_list.
// @param initializer_list
// @returns result
template <typename T>
inline T xirand::GetRandomElement(std::initializer_list<T> list)
{
    std::vector<T> container(list);
    return GetRandomElement(container);
}

// Get secure random numbers
size_t sysrandom(void* dst, size_t dstlen);

#endif // _XIRAND_H_
