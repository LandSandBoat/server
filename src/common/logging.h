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

#include "spdlog/common.h"
#include "spdlog/async.h"
#include "spdlog/spdlog.h"
#include "spdlog/sinks/basic_file_sink.h"
#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/sinks/rotating_file_sink.h"
#include "spdlog/fmt/fmt.h"
#include "spdlog/fmt/bundled/printf.h"

#include "cbasetypes.h"

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

    int32 _vShowMessage(MSGTYPE type, const std::string& msg);
}

// Legacy support
template <typename... Args>
int32 ShowMessage(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_NONE, fmt_string_v);
}

template <typename... Args>
int32 ShowStatus(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_STATUS, fmt_string_v);
}

template <typename... Args>
int32 ShowSQL(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_SQL, fmt_string_v);
}

template <typename... Args>
int32 ShowInfo(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_INFORMATION, fmt_string_v);
}

template <typename... Args>
int32 ShowNotice(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_NOTICE, fmt_string_v);
}

template <typename... Args>
int32 ShowWarning(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_WARNING, fmt_string_v);
}

template <typename... Args>
int32 ShowDebug(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_DEBUG, fmt_string_v);
}

template <typename... Args>
int32 ShowError(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_ERROR, fmt_string_v);
}

template <typename... Args>
int32 ShowFatalError(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_FATALERROR, fmt_string_v);
}

template <typename... Args>
int32 ShowScript(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_LUASCRIPT, fmt_string_v);
}

template <typename... Args>
int32 ShowNavError(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_NAVMESH, fmt_string_v);
}

template <typename... Args>
int32 ShowAction(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_ACTION, fmt_string_v);
}

template <typename... Args>
int32 ShowExploit(const std::string& fmt_string, Args... args)
{
    std::string fmt_string_v = fmt::sprintf(fmt_string, args...);
    return logging::_vShowMessage(MSG_EXPLOIT, fmt_string_v);
}

#endif // _LOGGING_H
