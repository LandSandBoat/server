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

#include "spdlog/fmt/fmt.h"
#include "spdlog/fmt/bundled/core.h"
#include "spdlog/fmt/bundled/format.h"
#include "spdlog/fmt/bundled/printf.h"
#include "spdlog/fmt/bundled/chrono.h"

enum MSGTYPE
{
    MSG_STANDARD    = 0x0001,
    MSG_STATUS      = 0x0002,
    MSG_INFO        = 0x0004,
    MSG_NOTICE      = 0x0008,
    MSG_WARNING     = 0x0010,
    MSG_DEBUG       = 0x0020,
    MSG_ERROR       = 0x0040,
    MSG_FATALERROR  = 0x0080,
    MSG_SQL         = 0x0100,
    MSG_LUASCRIPT   = 0x0200,
    MSG_NAVMESH     = 0x0400,
    MSG_ACTION      = 0x0800,
    MSG_EXPLOIT     = 0x1000,
};

namespace logging
{
    void InitializeLog(std::string serverName, std::string logFile, bool appendDate);
    void ShutDown();

    void SetFilters(int _filterMask);
}

// TODO: Build helpers around this macro (so function and line info can be preserved)
// #define SPDLOG_LOGGER_CALL(logger, level, ...) (logger)->log(spdlog::source_loc{__FILE__, __LINE__, SPDLOG_FUNCTION}, level, __VA_ARGS__)

// Legacy support
// TODO: Remove/replace these

#define MESSAGE_BASE(logLevel, spdlogLevel, __VA_ARGS__) { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); spdlogLevel(spdlog::get(logLevel), _msgStr); }

// Generic
#define ShowStandard(...)   MESSAGE_BASE("standard", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowInfo(...)       MESSAGE_BASE("info", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowMessage(...)    MESSAGE_BASE("message", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowStatus(...)     MESSAGE_BASE("status", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowNotice(...)     MESSAGE_BASE("notice", SPDLOG_LOGGER_WARN, __VA_ARGS__)
#define ShowWarning(...)    MESSAGE_BASE("warning", SPDLOG_LOGGER_WARN, __VA_ARGS__)
#define ShowDebug(...)      MESSAGE_BASE("debug", SPDLOG_LOGGER_DEBUG, __VA_ARGS__)
#define ShowError(...)      MESSAGE_BASE("error", SPDLOG_LOGGER_ERROR, __VA_ARGS__)
#define ShowFatalError(...) MESSAGE_BASE("fatalerror", SPDLOG_LOGGER_CRITICAL, __VA_ARGS__)

// Specific
#define ShowSQL(...)        MESSAGE_BASE("sql", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowScript(...)     MESSAGE_BASE("lua", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowAction(...)     MESSAGE_BASE("action", SPDLOG_LOGGER_INFO, __VA_ARGS__)
#define ShowExploit(...)    MESSAGE_BASE("exploit", SPDLOG_LOGGER_WARN, __VA_ARGS__)
#define ShowNavError(...)   MESSAGE_BASE("navmesh", SPDLOG_LOGGER_ERROR, __VA_ARGS__)
#define ShowStacktrace(...) MESSAGE_BASE("stacktrace", SPDLOG_LOGGER_CRITICAL, __VA_ARGS__)

#endif // _LOGGING_H
