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

#ifndef _MERSENNETWISTER_H_
#define _MERSENNETWISTER_H_

#include <array>
#include <random>

class xirand
{
public:
    static std::mt19937& rng()
    {
        static thread_local std::mt19937 e{};
        return e;
    }

    static void seed()
    {
        ShowInfo("Seeding Mersenne Twister 32 bit RNG");

        std::array<uint32_t, std::mt19937::state_size> seed_data;

        // Certain systems were noted to have bad seeding via only std::random_device,
        // the following indicated how we could mix in std::random_device with other seed sources
        // https://stackoverflow.com/a/68382489
        for (auto it = seed_data.begin(); it != seed_data.end(); ++it)
        {
            // start with a C++ equivalent of time(nullptr) - UNIX time in seconds
            *it = std::chrono::duration_cast<std::chrono::seconds>(
                      std::chrono::system_clock::now().time_since_epoch())
                      .count();

            // mix with a high precision time in microseconds
            *it ^= std::chrono::duration_cast<std::chrono::microseconds>(
                       std::chrono::high_resolution_clock::now().time_since_epoch())
                       .count();

            // *it ^= more_external_random_stuff;
        }
        std::seed_seq seq(seed_data.cbegin(), seed_data.cend());
        rng().seed(seq);
    }

    /*
        declarations for RNG methods implemented in xirand.h.
    */
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

#endif // _MERSENNETWISTER_H_
