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

#pragma once

#include "cbasetypes.h"
#include "macros.h"
#include "tracy.h"

#include <string>
#include <string_view>

#include <fmt/args.h>
#include <fmt/chrono.h>
#include <fmt/core.h>
#include <fmt/format.h>
#include <fmt/printf.h>
#include <fmt/ranges.h>

#include <spdlog/spdlog.h>

// Forward declaration
namespace settings
{

template <typename T>
T get(std::string);

} // namespace settings

namespace logging
{

void InitializeLog(const std::string& serverName, const std::string& logFile, bool appendDate);
void ShutDown();

void SetPattern(const std::string& str);

void AddBacktrace(const std::string& str);
auto GetBacktrace() -> std::vector<std::string>;

void tapWarningOrError();

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

#define END_CATCH_HANDLER(File, Line)                                                                             \
    }                                                                                                             \
    catch (std::exception const& ex)                                                                              \
    {                                                                                                             \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("Encountered logging exception!: %s", ex.what())); \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("%s:%i", File, Line));                             \
    }                                                                                                             \
    catch (...)                                                                                                   \
    {                                                                                                             \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("Encountered unhandled logging exception!"));      \
        SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("%s:%i", File, Line));                             \
    } STATEMENT_CLOSE

#define LOGGER_BODY(LOG_TYPE_MACRO, LogStringName, File, Line, ...) \
    BEGIN_CATCH_HANDLER const auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyZoneScoped; TracyMessageStr(_msgStr); logging::AddBacktrace(_msgStr); LOG_TYPE_MACRO(spdlog::get(LogStringName), _msgStr); END_CATCH_HANDLER(File, Line)

#define LOGGER_BODY_CONDITIONAL(LOG_TYPE_MACRO, LogStringName, LogConditionStr, File, Line, ...) \
    BEGIN_CATCH_HANDLER const auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyZoneScoped; TracyMessageStr(_msgStr); logging::AddBacktrace(_msgStr); if (settings::get<bool>(LogConditionStr)) { LOG_TYPE_MACRO(spdlog::get(LogStringName), _msgStr); } END_CATCH_HANDLER(File, Line)

#define LOGGER_BODY_FMT(LOG_TYPE_MACRO, LogStringName, File, Line, ...) \
    BEGIN_CATCH_HANDLER const auto _msgStr = fmt::format(__VA_ARGS__); TracyZoneScoped; TracyMessageStr(_msgStr); logging::AddBacktrace(_msgStr); LOG_TYPE_MACRO(spdlog::get(LogStringName), _msgStr); END_CATCH_HANDLER(File, Line)

#define LOGGER_BODY_CONDITIONAL_FMT(LOG_TYPE_MACRO, LogStringName, LogConditionStr, File, Line, ...) \
    BEGIN_CATCH_HANDLER const auto _msgStr = fmt::format(__VA_ARGS__); TracyZoneScoped; TracyMessageStr(_msgStr); logging::AddBacktrace(_msgStr); if (settings::get<bool>(LogConditionStr)) { LOG_TYPE_MACRO(spdlog::get(LogStringName), _msgStr); } END_CATCH_HANDLER(File, Line)

// Regular Loggers
// NOTE 1: Trace is not for logging to screen or file; it's for filling the backtrace buffer and reporting to Tracy.
// NOTE 2: It isn't possible (or a good idea) to allow the user to disable TRACE, ERROR, or CRITICAL logging.
#define ShowTrace(...)    logging::AddBacktrace(fmt::format("{}:{}: {}", __FILE__, __LINE__, fmt::sprintf(__VA_ARGS__)))
#define ShowDebug(...)    LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.LOG_DEBUG", __FILE__, __LINE__, __VA_ARGS__)
#define ShowInfo(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_INFO, "info", "logging.LOG_INFO", __FILE__, __LINE__, __VA_ARGS__)
#define ShowWarning(...)  LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_WARN, "warn", "logging.LOG_WARNING", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()
#define ShowLua(...)      LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_INFO, "lua", "logging.LOG_LUA", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()
#define ShowError(...)    LOGGER_BODY(SPDLOG_LOGGER_ERROR, "error", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()
#define ShowCritical(...) LOGGER_BODY(SPDLOG_LOGGER_CRITICAL, "critical", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()

// Regular Loggers fmt variants
#define ShowTraceFmt(...)    logging::AddBacktrace(fmt::format("{}:{}: {}", __FILE__, __LINE__, fmt::format(__VA_ARGS__)))
#define ShowDebugFmt(...)    LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.LOG_DEBUG", __FILE__, __LINE__, __VA_ARGS__)
#define ShowInfoFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_INFO, "info", "logging.LOG_INFO", __FILE__, __LINE__, __VA_ARGS__)
#define ShowWarningFmt(...)  LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_WARN, "warn", "logging.LOG_WARNING", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()
#define ShowLuaFmt(...)      LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_INFO, "lua", "logging.LOG_LUA", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()
#define ShowErrorFmt(...)    LOGGER_BODY_FMT(SPDLOG_LOGGER_ERROR, "error", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()
#define ShowCriticalFmt(...) LOGGER_BODY_FMT(SPDLOG_LOGGER_CRITICAL, "critical", __FILE__, __LINE__, __VA_ARGS__); logging::tapWarningOrError()

// Debug Loggers
#define DebugSockets(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_SOCKETS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugIPC(...)         LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_IPC", __FILE__, __LINE__, __VA_ARGS__)
#define DebugNavmesh(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_NAVMESH",__FILE__, __LINE__, __VA_ARGS__)
#define DebugPackets(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_PACKETS",__FILE__, __LINE__, __VA_ARGS__)
#define DebugActions(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_ACTIONS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugSQL(...)         LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_SQL", __FILE__, __LINE__, __VA_ARGS__)
#define DebugIDLookup(...)    LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_ID_LOOKUP", __FILE__, __LINE__, __VA_ARGS__)
#define DebugModules(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_MODULES", __FILE__, __LINE__, __VA_ARGS__)
#define DebugAuctions(...)    LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_AUCTIONS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugDeliveryBox(...) LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_DELIVERY_BOX", __FILE__, __LINE__, __VA_ARGS__)
#define DebugBazaars(...)     LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_BAZAARS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugPerformance(...) LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_PERFORMANCE", __FILE__, __LINE__, __VA_ARGS__)
#define DebugTest(...)        LOGGER_BODY_CONDITIONAL(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_TEST", __FILE__, __LINE__, __VA_ARGS__)

// Debug Loggers fmt variants
#define DebugSocketsFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_SOCKETS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugIPCFmt(...)         LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_IPC", __FILE__, __LINE__, __VA_ARGS__)
#define DebugNavmeshFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_NAVMESH", __FILE__, __LINE__, __VA_ARGS__)
#define DebugPacketsFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_PACKETS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugActionsFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_ACTIONS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugSQLFmt(...)         LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_SQL", __FILE__, __LINE__, __VA_ARGS__)
#define DebugIDLookupFmt(...)    LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_ID_LOOKUP", __FILE__, __LINE__, __VA_ARGS__)
#define DebugModulesFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_MODULES", __FILE__, __LINE__, __VA_ARGS__)
#define DebugAuctionsFmt(...)    LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_AUCTIONS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugDeliveryBoxFmt(...) LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_DELIVERY_BOX", __FILE__, __LINE__, __VA_ARGS__)
#define DebugBazaarsFmt(...)     LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_BAZAARS", __FILE__, __LINE__, __VA_ARGS__)
#define DebugPerformanceFmt(...) LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_PERFORMANCE", __FILE__, __LINE__, __VA_ARGS__)
#define DebugTestFmt(...)        LOGGER_BODY_CONDITIONAL_FMT(SPDLOG_LOGGER_DEBUG, "debug", "logging.DEBUG_TEST", __FILE__, __LINE__, __VA_ARGS__)

// clang-format on
