#ifndef _CBASETYPES_H_
#define _CBASETYPES_H_

#include <algorithm>
#include <cctype>
#include <climits>
#include <cstddef>
#include <cstdint>
#include <utility>

#include "logging.h"
#include "macros.h"

// typedef/using
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

#include <chrono>

using namespace std::literals::chrono_literals;
using server_clock = std::chrono::system_clock;
using time_point   = server_clock::time_point;
using duration     = server_clock::duration;

using hires_clock      = std::chrono::high_resolution_clock;
using hires_time_point = server_clock::time_point;
using hires_duration   = server_clock::duration;

#include <queue>

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

#include "tracy.h"

#endif /* _CBASETYPES_H_ */
