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

#define SPDLOG_LEVEL_TRACE    0
#define SPDLOG_LEVEL_DEBUG    1
#define SPDLOG_LEVEL_INFO     2
#define SPDLOG_LEVEL_WARN     3
#define SPDLOG_LEVEL_ERROR    4
#define SPDLOG_LEVEL_CRITICAL 5
#define SPDLOG_LEVEL_OFF      6
#define SPDLOG_ACTIVE_LEVEL SPDLOG_LEVEL_TRACE
#define SPDLOG_DEBUG_ON
#define SPDLOG_TRACE_ON
#include "spdlog/spdlog.h"
#include "spdlog/fmt/bundled/printf.h"

#include <string>

enum MSGTYPE
{
    MSG_NONE        = 0x0001,
    MSG_STATUS      = 0x0002,
    MSG_INFORMATION = 0x0004,
    MSG_NOTICE      = 0x0008,
    MSG_WARNING     = 0x0010,
    MSG_DEBUG       = 0x0020,
    MSG_ERROR       = 0x0040,
    MSG_FATALERROR  = 0x0080,
    MSG_SQL         = 0x0100,
    MSG_LUASCRIPT   = 0x0200,
    MSG_NAVMESH     = 0x0400,
    MSG_ACTION      = 0x0800,
    MSG_EXPLOIT     = 0x1000
};

namespace logging
{
    void InitializeLog(std::string name, std::string logFile);
    void ShutDown();
}

// Legacy support
// TODO: Remove/replace these
#define ShowMessage(...)    SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowStatus(...)     SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowSQL(...)        SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowInfo(...)       SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowNotice(...)     SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowWarning(...)    SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowDebug(...)      SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowError(...)      SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowFatalError(...) SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowScript(...)     SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowNavError(...)   SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowAction(...)     SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))
#define ShowExploit(...)    SPDLOG_INFO(fmt::sprintf(__VA_ARGS__))

#endif // _LOGGING_H
