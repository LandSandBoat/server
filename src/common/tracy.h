#ifndef _TRACY_H
#define _TRACY_H

// clang-format off
#ifdef TRACY_ENABLE
#include "tracy/Tracy.hpp"
#include "cbasetypes.h"

#define TracyFrameMark          FrameMark
#define TracyZoneScoped         ZoneScoped;
#define TracyZoneScopedN(n)     ZoneScopedN(n)
#define TracyZoneNamed(var)     ZoneNamedN(var, #var, true)
#define TracyZoneText(n, l)     ZoneText(n, l)
#define TracyZoneScopedC(c)     ZoneScopedC(c)
#define TracyZoneString(str)    ZoneText(str.c_str(), str.size())
#define TracyZoneCString(cstr)  ZoneText(cstr, std::strlen(cstr))
#define TracyMessageStr(str)    TracyMessage(str.c_str(), str.size())
#define TracySetThreadName(str) tracy::SetThreadName(str);

inline std::string Hex8ToString(uint8 hex)
{
    return fmt::format("0x{:02X}", hex);
}

inline std::string Hex16ToString(uint16 hex)
{
    return fmt::format("0x{:04X}", hex);
}

#define TracyZoneHex8(num) \
    auto str = Hex8ToString(num); \
    TracyZoneText(str.c_str(), str.size());

#define TracyZoneHex16(num) \
    auto str = Hex16ToString(num); \
    TracyZoneText(str.c_str(), str.size());

#define TracyReportGraphNumber(name, num) \
    TracyPlotConfig(name, tracy::PlotFormatType::Number, false, true, 0); \
    TracyPlot(name, num);

#define TracyReportGraphBytes(name, num) \
    TracyPlotConfig(name, tracy::PlotFormatType::Memory, false, true, 0); \
    TracyPlot(name, num);

#define TracyReportGraphPercent(name, num) \
    TracyPlotConfig(name, tracy::PlotFormatType::Percentage, false, true, 0); \
    TracyPlot(name, num);

#define TracyReportLuaMemory(L) \
    TracyReportGraphBytes("Lua Memory Usage", static_cast<double>(lua_gc(L, LUA_GCCOUNT, 0)) * 1024.0); \

#else // Empty stubs for regular builds
#define TracyFrameMark                     ;
#define TracyZoneScoped                    ShowTrace(__func__);
#define TracyZoneScopedN(n)                std::ignore = n;
#define TracyZoneNamed(var)                std::ignore = #var;
#define TracyZoneText(n, l)                std::ignore = n; std::ignore = l;
#define TracyZoneScopedC(c)                std::ignore = c;
#define TracyZoneString(str)               std::ignore = str;
#define TracyZoneCString(cstr)             std::ignore = cstr;
#define TracyZoneIString(istr)             std::ignore = istr;
#define TracyZoneHex8(num)                 std::ignore = num;
#define TracyZoneHex16(num)                std::ignore = num;
#define TracyReportGraphNumber(name, num)  std::ignore = name; std::ignore = num;
#define TracyReportGraphBytes(name, num)   std::ignore = name; std::ignore = num;
#define TracyReportGraphPercent(name, num) std::ignore = name; std::ignore = num;
#define TracyReportLuaMemory(L)            std::ignore = L;
#define TracyMessageStr(str)               std::ignore = str;
#define TracySetThreadName(str)            std::ignore = str;
#endif
// clang-format on

#endif // _TRACY_H
