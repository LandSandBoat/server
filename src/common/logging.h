/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Teams

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

#ifndef _LOGGING_H
#define _LOGGING_H

#include "cbasetypes.h"
#include "tracy.h"

#include <string>
#include <string_view>

// Set this higher to strip out lower messages at compile time
// NOTE: We don't strip anything by default, as we use all the logger
//     : levels for different things.
#define SPDLOG_ACTIVE_LEVEL SPDLOG_LEVEL_TRACE

// TODO: Remove this
#define FMT_CONSTEVAL

#include <fmt/args.h>
#include <fmt/chrono.h>
#include <fmt/core.h>
#include <fmt/format.h>
#include <fmt/printf.h>

#include "spdlog/spdlog.h"

// Forward declaration
namespace settings
{
    template <typename T>
    T get(std::string);
} // namespace settings

namespace logging
{
    void InitializeLog(std::string const& serverName, std::string const& logFile, bool appendDate);
    void ShutDown();

    void SetPattern(std::string const& str);

    void AddBacktrace(std::string const& str);
    auto GetBacktrace() -> std::vector<std::string>;
} // namespace logging

// clang-format off

template <typename T>
std::string asStringFromUntrustedSource(const T* ptr)
{
    if (!ptr)
    {
        return "";
    }

    static constexpr size_t MAX_STRING_LENGTH = 1024;

    const auto str = reinterpret_cast<const char*>(ptr);
    return std::string(str, strnlen(str, MAX_STRING_LENGTH));
}

template <typename T>
std::string asStringFromUntrustedSource(const T* ptr, size_t max_size)
{
    if (!ptr)
    {
        return "";
    }

    const auto str = reinterpret_cast<const char*>(ptr);
    const auto len = strnlen(str, max_size);
    return std::string(str, len);
}

// Helper for allowing `enum` and `enum class` types to be formatted
// as their underlying numeric type.
#define DECLARE_FORMAT_AS_UNDERLYING(type) \
inline auto format_as(type v) \
{ \
    return fmt::underlying(v); \
}

#define STATEMENT_CLOSE \
    std::ignore = 0

// NOTE: In order to preserve the ability for Tracy and spdlog to track the source location of
//     : logging calls, we have to stack a lot of macros. This leads to some strangeness with
//     : the output of Tracy: Each logging call creates its own scope, and will have its own
//     : entry in the Tracy statistics. This is a low price to pay for the ability to profile
//     : logging calls, and everything else, and still have all the information we want delivered
//     : to the logging system.
#define BEGIN_CATCH_HANDLER \
    try                     \
    {

#define END_CATCH_HANDLER                                                                                         \
    }                                                                                                            \
    catch (std::exception const& ex)                                                                              \
    {                                                                                                             \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("Encountered logging exception!: %s", ex.what())); \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("%s:%i", __FILE__, __LINE__));                     \
    }                                                                                                             \
    catch (...)                                                                                                   \
    {                                                                                                             \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("Encountered unhandled logging exception!"));      \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("%s:%i", __FILE__, __LINE__));                     \
    } STATEMENT_CLOSE

#define LOGGER_BODY(LOG_TYPE_MACRO, LogStringName, ...) \
    BEGIN_CATCH_HANDLER auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyZoneScoped; TracyMessageStr(_msgStr); LOG_TYPE_MACRO(spdlog::get(LogStringName), _msgStr); END_CATCH_HANDLER

#define LOGGER_BODY_FMT(LOG_TYPE_MACRO, LogStringName, ...) \
    BEGIN_CATCH_HANDLER auto _msgStr = fmt::format(__VA_ARGS__); TracyZoneScoped; TracyMessageStr(_msgStr); LOG_TYPE_MACRO(spdlog::get(LogStringName), _msgStr); END_CATCH_HANDLER

#define LOGGER_ENABLE(SettingsString, ...) \
    if (settings::get<bool>(SettingsString)) { __VA_ARGS__ ; } STATEMENT_CLOSE

// Regular Loggers
// NOTE 1: Trace is not for logging to screen or file; it's for filling the crash backtrace buffer and reporting to Tracy.
// NOTE 2: It isn't possible (or a good idea) to allow the user to disable TRACE, ERROR, or CRITICAL logging.
#define ShowTrace(...)    logging::AddBacktrace(fmt::sprintf(__VA_ARGS__))
#define ShowDebug(...)    LOGGER_ENABLE("logging.LOG_DEBUG", LOGGER_BODY(SPDLOG_LOGGER_DEBUG, "debug", __VA_ARGS__))
#define ShowInfo(...)     LOGGER_ENABLE("logging.LOG_INFO", LOGGER_BODY(SPDLOG_LOGGER_INFO, "info", __VA_ARGS__))
#define ShowWarning(...)  LOGGER_ENABLE("logging.LOG_WARNING", LOGGER_BODY(SPDLOG_LOGGER_WARN, "warn", __VA_ARGS__))
#define ShowLua(...)      LOGGER_ENABLE("logging.LOG_LUA", LOGGER_BODY(SPDLOG_LOGGER_INFO, "lua", __VA_ARGS__))
#define ShowError(...)    LOGGER_BODY(SPDLOG_LOGGER_ERROR, "error", __VA_ARGS__)
#define ShowCritical(...) LOGGER_BODY(SPDLOG_LOGGER_CRITICAL, "critical", __VA_ARGS__)

// Regular Loggers fmt variants
#define ShowTraceFmt(...)    logging::AddBacktrace(fmt::format(__VA_ARGS__))
#define ShowDebugFmt(...)    LOGGER_ENABLE("logging.LOG_DEBUG", LOGGER_BODY_FMT(SPDLOG_LOGGER_DEBUG, "debug", __VA_ARGS__))
#define ShowInfoFmt(...)     LOGGER_ENABLE("logging.LOG_INFO", LOGGER_BODY_FMT(SPDLOG_LOGGER_INFO, "info", __VA_ARGS__))
#define ShowWarningFmt(...)  LOGGER_ENABLE("logging.LOG_WARNING", LOGGER_BODY_FMT(SPDLOG_LOGGER_WARN, "warn", __VA_ARGS__))
#define ShowLuaFmt(...)      LOGGER_ENABLE("logging.LOG_LUA", LOGGER_BODY_FMT(SPDLOG_LOGGER_INFO, "lua", __VA_ARGS__))
#define ShowErrorFmt(...)    LOGGER_BODY_FMT(SPDLOG_LOGGER_ERROR, "error", __VA_ARGS__)
#define ShowCriticalFmt(...) LOGGER_BODY_FMT(SPDLOG_LOGGER_CRITICAL, "critical", __VA_ARGS__)

// Debug Loggers
#define DebugSockets(...)     LOGGER_ENABLE("logging.DEBUG_SOCKETS", ShowDebug(__VA_ARGS__))
#define DebugNavmesh(...)     LOGGER_ENABLE("logging.DEBUG_NAVMESH", ShowDebug(__VA_ARGS__))
#define DebugPackets(...)     LOGGER_ENABLE("logging.DEBUG_PACKETS", ShowDebug(__VA_ARGS__))
#define DebugActions(...)     LOGGER_ENABLE("logging.DEBUG_ACTIONS", ShowDebug(__VA_ARGS__))
#define DebugSQL(...)         LOGGER_ENABLE("logging.DEBUG_SQL", ShowDebug(__VA_ARGS__))
#define DebugIDLookup(...)    LOGGER_ENABLE("logging.DEBUG_ID_LOOKUP", ShowDebug(__VA_ARGS__))
#define DebugModules(...)     LOGGER_ENABLE("logging.DEBUG_MODULES", ShowDebug(__VA_ARGS__))
#define DebugAuctions(...)    LOGGER_ENABLE("logging.DEBUG_AUCTIONS", ShowDebug(__VA_ARGS__))
#define DebugDeliveryBox(...) LOGGER_ENABLE("logging.DEBUG_DELIVERY_BOX", ShowDebug(__VA_ARGS__))
#define DebugBazaars(...)     LOGGER_ENABLE("logging.DEBUG_BAZAARS", ShowDebug(__VA_ARGS__))

// Debug Loggers fmt variants
#define DebugSocketsFmt(...)     LOGGER_ENABLE("logging.DEBUG_SOCKETS", ShowDebugFmt(__VA_ARGS__))
#define DebugNavmeshFmt(...)     LOGGER_ENABLE("logging.DEBUG_NAVMESH", ShowDebugFmt(__VA_ARGS__))
#define DebugPacketsFmt(...)     LOGGER_ENABLE("logging.DEBUG_PACKETS", ShowDebugFmt(__VA_ARGS__))
#define DebugActionsFmt(...)     LOGGER_ENABLE("logging.DEBUG_ACTIONS", ShowDebugFmt(__VA_ARGS__))
#define DebugSQLFmt(...)         LOGGER_ENABLE("logging.DEBUG_SQL", ShowDebugFmt(__VA_ARGS__))
#define DebugIDLookupFmt(...)    LOGGER_ENABLE("logging.DEBUG_ID_LOOKUP", ShowDebugFmt(__VA_ARGS__))
#define DebugModulesFmt(...)     LOGGER_ENABLE("logging.DEBUG_MODULES", ShowDebugFmt(__VA_ARGS__))
#define DebugAuctionsFmt(...)    LOGGER_ENABLE("logging.DEBUG_AUCTIONS", ShowDebugFmt(__VA_ARGS__))
#define DebugDeliveryBoxFmt(...) LOGGER_ENABLE("logging.DEBUG_DELIVERY_BOX", ShowDebugFmt(__VA_ARGS__))
#define DebugBazaarsFmt(...)     LOGGER_ENABLE("logging.DEBUG_BAZAARS", ShowDebugFmt(__VA_ARGS__))

// clang-format on

#endif // _LOGGING_H
