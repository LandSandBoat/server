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

namespace logging
{
    void InitializeLog(std::string serverName, std::string logFile, bool appendDate);
    void ShutDown();
    void UpdateFilters();
} // namespace logging

// TODO: Build helpers around this macro (so function and line info can be preserved)
// #define SPDLOG_LOGGER_CALL(logger, level, ...) (logger)->log(spdlog::source_loc{__FILE__, __LINE__, SPDLOG_FUNCTION}, level, __VA_ARGS__)

// clang-format off

#define ShowTrace(...)    { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_TRACE(spdlog::get("trace"), _msgStr); }
#define ShowDebug(...)    { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_DEBUG(spdlog::get("debug"), _msgStr); }
#define ShowInfo(...)     { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_INFO(spdlog::get("info"), _msgStr); }
#define ShowWarning(...)  { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_WARN(spdlog::get("warning"), _msgStr); }
#define ShowError(...)    { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_ERROR(spdlog::get("error"), _msgStr); }
#define ShowCritical(...) { auto _msgStr = fmt::sprintf(__VA_ARGS__); TracyMessageStr(_msgStr); SPDLOG_LOGGER_CRITICAL(spdlog::get("critical"), _msgStr); }
// clang-format on

#endif // _LOGGING_H
