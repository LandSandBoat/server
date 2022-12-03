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

#include <string>

// Set this higher to strip out lower messages at compile time
#define SPDLOG_ACTIVE_LEVEL SPDLOG_LEVEL_TRACE

#include "spdlog/spdlog.h"

#include "spdlog/fmt/bundled/chrono.h"
#include "spdlog/fmt/bundled/core.h"
#include "spdlog/fmt/bundled/format.h"
#include "spdlog/fmt/bundled/printf.h"
#include "spdlog/fmt/fmt.h"

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
} // namespace logging

// clang-format off

// NOTE: In order to preserve the ability for Tracy and spdlog to track the source location of
//     : logging calls, we have to stack a lot of macros. This leads to some strangeness with
//     : the output of Tracy: Each logging call creates its own scope, and will have its own
//     : entry in the Tracy statistics. This is a low price to pay for the ability to profile
//     : logging calls, and everything else, and still have all the information we want delivered
//     : to the logging system.
#define BEGIN_CATCH_HANDLER  \
    {                        \
        TracyZoneNamed(Log); \
        try                  \
        {

#define END_CATCH_HANDLER                                                                                             \
        }                                                                                                             \
        catch (std::exception const& ex)                                                                              \
        {                                                                                                             \
            SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("Encountered logging exception!: %s", ex.what())); \
            SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("%s:%i", __FILE__, __LINE__));                     \
        }                                                                                                             \
        catch (...)                                                                                                   \
        {                                                                                                             \
            SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("Encountered unhandled logging exception!"));      \
            SPDLOG_LOGGER_ERROR(spdlog::get("error"), fmt::sprintf("%s:%i", __FILE__, __LINE__));                     \
        }                                                                                                             \
    }

// Regular Loggers
#define ShowTrace(...)    BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_TRACE(spdlog::get("trace"), _msgStr); } END_CATCH_HANDLER
#define ShowDebug(...)    BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_DEBUG(spdlog::get("debug"), _msgStr); } END_CATCH_HANDLER
#define ShowInfo(...)     BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("info"), _msgStr); } END_CATCH_HANDLER
#define ShowWarning(...)  BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_WARN(spdlog::get("warn"), _msgStr); } END_CATCH_HANDLER
#define ShowError(...)    BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_ERROR(spdlog::get("error"), _msgStr); } END_CATCH_HANDLER
#define ShowCritical(...) BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_CRITICAL(spdlog::get("critical"), _msgStr); } END_CATCH_HANDLER

// Special Loggers
#define ShowLua(...) BEGIN_CATCH_HANDLER { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("lua"), _msgStr); } END_CATCH_HANDLER

// Debug Loggers
#define DebugSockets(...)  { if (settings::get<bool>("logging.DEBUG_SOCKETS"))   { ShowDebug(__VA_ARGS__); } }
#define DebugNavmesh(...)  { if (settings::get<bool>("logging.DEBUG_NAVMESH"))   { ShowDebug(__VA_ARGS__); } }
#define DebugPackets(...)  { if (settings::get<bool>("logging.DEBUG_PACKETS"))   { ShowDebug(__VA_ARGS__); } }
#define DebugActions(...)  { if (settings::get<bool>("logging.DEBUG_ACTIONS"))   { ShowDebug(__VA_ARGS__); } }
#define DebugSQL(...)      { if (settings::get<bool>("logging.DEBUG_SQL"))       { ShowDebug(__VA_ARGS__); } }
#define DebugIDLookup(...) { if (settings::get<bool>("logging.DEBUG_ID_LOOKUP")) { ShowDebug(__VA_ARGS__); } }
#define DebugModules(...)  { if (settings::get<bool>("logging.DEBUG_MODULES"))   { ShowDebug(__VA_ARGS__); } }

// Crash dump utils
#define DumpBacktrace() spdlog::get("trace")->dump_backtrace()

// clang-format on

#endif // _LOGGING_H
