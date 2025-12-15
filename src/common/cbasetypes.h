/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include <algorithm>
#include <cctype>
#include <chrono>
#include <climits>
#include <cstddef>
#include <cstdint>
#include <queue>
#include <span>
#include <utility>
#include <vector>

#include "macros.h"
#include "tracy.h"

#include "types/flag.h"

using int8  = std::int8_t;
using int16 = std::int16_t;
using int32 = std::int32_t;
using int64 = std::int64_t;

using uint8  = std::uint8_t;
using uint16 = std::uint16_t;
using uint32 = std::uint32_t;
using uint64 = std::uint64_t;

using i8  = std::int8_t;
using i16 = std::int16_t;
using i32 = std::int32_t;
using i64 = std::int64_t;

using u8  = std::uint8_t;
using u16 = std::uint16_t;
using u32 = std::uint32_t;
using u64 = std::uint64_t;

using f32 = float;
using f64 = double;

template <typename T>
inline void destroy(T*& ptr)
{
    delete ptr; // cpp.sh allow
    ptr = nullptr;
}

template <typename T>
inline void destroy_arr(T*& ptr)
{
    delete[] ptr; // cpp.sh allow
    ptr = nullptr;
}

using namespace std::literals::chrono_literals;

template <class T>
using MinHeap = std::priority_queue<T, std::vector<T>, std::greater<T>>;

template <typename T>
struct PtrGreater
{
    bool operator()(const T left, const T right)
    {
        return *left > *right;
    }
};

template <class T>
using MinHeapPtr = std::priority_queue<T, std::vector<T>, PtrGreater<T>>;
