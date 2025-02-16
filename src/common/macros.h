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

// The following definitions are set by CMake based on the architecture
// #define ENV64BIT
// #define ENV32BIT

// Ensure one of the definitions is set
#if !defined(ENV64BIT) && !defined(ENV32BIT)
#error "Neither ENV64BIT nor ENV32BIT is defined"
#endif

// Debug mode
#if defined(_DEBUG) && !defined(DEBUG)
#define DEBUG
#endif

// Release mode
#if !defined(_DEBUG) && !defined(RELEASE)
#define RELEASE
#endif

// define a break macro for debugging
#define XI_DEBUG_BREAK_IF(_CONDITION_) \
    static_assert(false, "Use of XI_DEBUG_BREAK_IF is deprecated. Check your conditions and log appropriately instead.")

#define DISALLOW_COPY(TypeName)                    \
    TypeName(const TypeName&)            = delete; \
    TypeName& operator=(const TypeName&) = delete;

#define DISALLOW_MOVE(TypeName)               \
    TypeName(TypeName&&)            = delete; \
    TypeName& operator=(TypeName&&) = delete;

#define DISALLOW_COPY_AND_MOVE(TypeName) \
    DISALLOW_COPY(TypeName)              \
    DISALLOW_MOVE(TypeName)

//
// This `FOR_EACH_PAIR_CAST_SECOND` macro replaces a common pattern we had in the hot path:
//
// ```cpp
//     for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
//     {
//         CCharEntity* PCurrentChar = (CCharEntity*)it->second;
// ```
//
// It provides a cleaner and more concise way to iterate over collections
// while maintaining the same performance characteristics as the original code.
//
// Both the original and macro version produce identical assembly output.
//
// Assembly Analysis: https://github.com/LandSandBoat/server/pull/6751
//
#define FOR_EACH_PAIR_CAST_SECOND(_type, _var, _collection) \
    for (const auto& [_key, _value] : _collection)          \
        if (auto _var = static_cast<_type>(_value); true)

#define FOR_DB_SINGLE_RESULT(_rset) \
    if (_rset && _rset->rowsCount() && _rset->next())

#define FOR_DB_MULTIPLE_RESULTS(_rset) \
    if (_rset && _rset->rowsCount())   \
        while (_rset->next())

// string case comparison for *nix portability
#if !defined(_MSC_VER)
#define strcmpi strcasecmp
#define stricmp strcasecmp

// https://stackoverflow.com/questions/12044519/what-is-the-windows-equivalent-of-the-unix-function-gmtime-r
// gmtime_r() is the thread-safe version of gmtime(). The MSVC implementation of gmtime() is already thread safe,
// the returned struct tm* is allocated in thread-local storage.
// That doesn't make it immune from trouble if the function is called multiple times on the same
// thread and the returned pointer is stored.
// You can use gmtime_s() instead. Closest to gmtime_r() but with the arguments reversed

// Provide func_s implementations for Unix
#define _gmtime_s(a, b)    gmtime_r(b, a)
#define _localtime_s(a, b) localtime_r(b, a)
#else // MSVC
#define _gmtime_s(a, b)    gmtime_s(a, b)
#define _localtime_s(a, b) localtime_s(a, b)
#endif
