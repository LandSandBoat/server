#ifndef _CBASETYPES_H_
#define _CBASETYPES_H_

#include <algorithm>
#include <cctype>
#include <climits>
#include <cstddef>
#include <cstdint>

// debug mode
#if defined(_DEBUG) && !defined(DEBUG)
#define DEBUG
#endif

// define a break macro for debugging.
#if defined(DEBUG)
#if defined(_MSC_VER)
#define TPZ_DEBUG_BREAK_IF(_CONDITION_)                                                                                                                        \
    if (_CONDITION_)                                                                                                                                           \
    {                                                                                                                                                          \
        __debugbreak();                                                                                                                                        \
    }
#else
#include "assert.h"
#define TPZ_DEBUG_BREAK_IF(_CONDITION_) assert(!(_CONDITION_));
#endif
#else
#define TPZ_DEBUG_BREAK_IF(_CONDITION_)
#endif

// typedef/using
using int8  = std::int8_t;
using int16 = std::int16_t;
using int32 = std::int32_t;
using int64 = std::int64_t;

using uint8  = std::uint8_t;
using uint16 = std::uint16_t;
using uint32 = std::uint32_t;
using uint64 = std::uint64_t;

// string case comparison for *nix portability
#if !defined(_MSC_VER)
#define strcmpi strcasecmp
#define stricmp strcasecmp
#endif

#include <chrono>

using namespace std::literals::chrono_literals;
using server_clock = std::chrono::system_clock;
using time_point   = server_clock::time_point;
using duration     = server_clock::duration;

#include "tracy.h"

#endif /* _CBASETYPES_H_ */
