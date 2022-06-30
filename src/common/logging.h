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

#define SPDLOG_NO_THREAD_ID

#include "spdlog/spdlog.h"

#include "spdlog/fmt/bundled/chrono.h"
#include "spdlog/fmt/bundled/core.h"
#include "spdlog/fmt/bundled/format.h"
#include "spdlog/fmt/bundled/printf.h"
#include "spdlog/fmt/fmt.h"

enum MSGTYPE
{
    MSG_STANDARD   = 0x0001,
    MSG_STATUS     = 0x0002,
    MSG_INFO       = 0x0004,
    MSG_NOTICE     = 0x0008,
    MSG_WARNING    = 0x0010,
    MSG_DEBUG      = 0x0020,
    MSG_ERROR      = 0x0040,
    MSG_FATALERROR = 0x0080,
    MSG_SQL        = 0x0100,
    MSG_LUASCRIPT  = 0x0200,
    MSG_NAVMESH    = 0x0400,
    MSG_ACTION     = 0x0800,
    MSG_EXPLOIT    = 0x1000,
};

namespace logging
{
    void InitializeLog(std::string serverName, std::string logFile, bool appendDate);
    void ShutDown();

    void SetFilters(int _filterMask);
} // namespace logging

// TODO: Build helpers around this macro (so function and line info can be preserved)
// #define SPDLOG_LOGGER_CALL(logger, level, ...) (logger)->log(spdlog::source_loc{__FILE__, __LINE__, SPDLOG_FUNCTION}, level, __VA_ARGS__)

// Legacy support
// TODO: Remove/replace these

// Generic
// clang-format off
#define ShowStandard(...)   { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("standard"), _msgStr); }
#define ShowInfo(...)       { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("info"), _msgStr); }
#define ShowMessage(...)    { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("message"), _msgStr); }
#define ShowStatus(...)     { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("status"), _msgStr); }
#define ShowNotice(...)     { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_WARN(spdlog::get("notice"), _msgStr); }
#define ShowWarning(...)    { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_WARN(spdlog::get("warning"), _msgStr); }
#define ShowDebug(...)      { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_DEBUG(spdlog::get("debug"), _msgStr); }
#define ShowError(...)      { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_ERROR(spdlog::get("error"), _msgStr); }
#define ShowFatalError(...) { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_CRITICAL(spdlog::get("fatalerror"), _msgStr); }

// Specific
#define ShowSQL(...)        { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("sql"), _msgStr); }
#define ShowScript(...)     { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("lua"), _msgStr); }
#define ShowAction(...)     { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("action"), _msgStr); }
#define ShowExploit(...)    { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_WARN(spdlog::get("exploit"), _msgStr); }
#define ShowNavError(...)   { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_ERROR(spdlog::get("navmesh"), _msgStr); }
#define ShowStacktrace(...) { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_CRITICAL(spdlog::get("stacktrace"), _msgStr); }
// clang-format on

#endif // _LOGGING_H
