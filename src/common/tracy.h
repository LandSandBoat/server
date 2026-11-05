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

#include <cstdint>
#include <string>

#include <fmt/format.h>

//
// TODO: Move these somewhere else
//

inline auto hex8ToString(std::uint8_t hex) -> std::string
{
    return fmt::format("0x{:02X}", hex);
}

inline auto hex16ToString(std::uint16_t hex) -> std::string
{
    return fmt::format("0x{:04X}", hex);
}

inline auto hex32ToString(std::uint32_t hex) -> std::string
{
    return fmt::format("0x{:08X}", hex);
}

// clang-format off
#ifdef TRACY_ENABLE

#include "tracy/Tracy.hpp"

#include <cstdint>
#include <fmt/format.h>
#include <string>

#define TracyFrameMark            FrameMark
#define TracyZoneScoped           ZoneScoped
#define TracyZoneScopedN(n)       ZoneScopedN(n)
#define TracyZoneNamed(var, name) ZoneNamedN(var, name, true)
#define TracyZoneText(n, l)       ZoneText(n, l)
#define TracyZoneScopedC(c)       ZoneScopedC(c)
#define TracyZoneScopedNC(n, c)   ZoneScopedNC(n, c)
#define TracyZoneScopedS(depth)   ZoneScopedS(depth)
#define TracyZoneString(str)      ZoneText(str.data(), str.size())
#define TracyZoneCString(cstr)    ZoneText(cstr, std::strlen(cstr))
#define TracyMessageStr(str)      TracyMessage(str.c_str(), str.size())
#define TracySetThreadName(str)   tracy::SetThreadName(str)

// Multi-statement macros are wrapped in do/while so the caller's semicolon ends them.
#define TracyZoneHex8(num) \
    do { \
        const auto str = hex8ToString(num); \
        TracyZoneText(str.c_str(), str.size()); \
    } while (0)

#define TracyZoneHex16(num) \
    do { \
        const auto str = hex16ToString(num); \
        TracyZoneText(str.c_str(), str.size()); \
    } while (0)

#define TracyZoneHex32(num) \
    do { \
        const auto str = hex32ToString(num); \
        TracyZoneText(str.c_str(), str.size()); \
    } while (0)

#define TracyReportGraphNumber(name, num) \
    do { \
        TracyPlotConfig(name, tracy::PlotFormatType::Number, false, true, 0); \
        TracyPlot(name, num); \
    } while (0)

#define TracyReportGraphBytes(name, num) \
    do { \
        TracyPlotConfig(name, tracy::PlotFormatType::Memory, false, true, 0); \
        TracyPlot(name, num); \
    } while (0)

#define TracyReportGraphPercent(name, num) \
    do { \
        TracyPlotConfig(name, tracy::PlotFormatType::Percentage, false, true, 0); \
        TracyPlot(name, num); \
    } while (0)

#define TracyReportLuaMemory(L) \
    TracyReportGraphBytes("Lua Memory Usage", static_cast<double>(lua_gc(L, LUA_GCCOUNT, 0)) * 1024.0)

#else // Empty stubs for regular builds
// decltype never evaluates its operand, but still counts as a use of it.
#define TracyFrameMark                     static_cast<void>(0)
#define TracyZoneScoped                    static_cast<void>(0)
#define TracyZoneScopedN(n)                static_cast<void>(sizeof(decltype(n)))
#define TracyZoneNamed(var, name)          static_cast<void>(sizeof(decltype(name)))
#define TracyZoneText(n, l)                static_cast<void>(sizeof(decltype(n)) + sizeof(decltype(l)))
#define TracyZoneScopedC(c)                static_cast<void>(sizeof(decltype(c)))
#define TracyZoneScopedNC(n, c)            static_cast<void>(sizeof(decltype(n)) + sizeof(decltype(c)))
#define TracyZoneScopedS(depth)            static_cast<void>(sizeof(decltype(depth)))
#define TracyZoneString(str)               static_cast<void>(sizeof(decltype(str)))
#define TracyZoneCString(cstr)             static_cast<void>(sizeof(decltype(cstr)))
#define TracyZoneHex8(num)                 static_cast<void>(sizeof(decltype(num)))
#define TracyZoneHex16(num)                static_cast<void>(sizeof(decltype(num)))
#define TracyZoneHex32(num)                static_cast<void>(sizeof(decltype(num)))
#define TracyReportGraphNumber(name, num)  static_cast<void>(sizeof(decltype(name)) + sizeof(decltype(num)))
#define TracyReportGraphBytes(name, num)   static_cast<void>(sizeof(decltype(name)) + sizeof(decltype(num)))
#define TracyReportGraphPercent(name, num) static_cast<void>(sizeof(decltype(name)) + sizeof(decltype(num)))
#define TracyReportLuaMemory(L)            static_cast<void>(sizeof(decltype(L)))
#define TracyMessageStr(str)               static_cast<void>(sizeof(decltype(str)))
#define TracySetThreadName(str)            static_cast<void>(sizeof(decltype(str)))
#define TracyLockable(m, n)                m n
#define TracySharedLockable(m, n)          m n
#define LockableBase(type)                 type
#define SharedLockableBase(type)           type
#define LockMark(m)                        std::ignore = m
#endif
// clang-format on
