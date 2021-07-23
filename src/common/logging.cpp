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

#include "logging.h"
#include "tracy.h"

#include "spdlog/common.h"
#include "spdlog/async.h"
#include "spdlog/pattern_formatter.h"
#include "spdlog/sinks/basic_file_sink.h"
#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/sinks/daily_file_sink.h"
#include "spdlog/fmt/fmt.h"
#include "spdlog/fmt/bundled/printf.h"

uint32 filterMask = 0;

namespace logging
{
    void InitializeLog(std::string serverName, std::string logFile)
    {
        TracyZoneScoped;

        // If you create more than one worker thread, messages may be delivered out of order
        spdlog::init_thread_pool(8192, 1);

        // Sink to console
        auto stdout_sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();

        // Sink to files, creating new files at midnight
        auto daily_sink = std::make_shared<spdlog::sinks::daily_file_sink_mt>(logFile, 0, 00, false, 0);

        std::vector<spdlog::sink_ptr> sinks{ stdout_sink, daily_sink };

        // https://github.com/gabime/spdlog/wiki/3.-Custom-formatting
        // [date time:ms][server name][log level][logger name] message (func_name:func_line)
        //                            ^---  level colour  ---^
        auto defaultPattern = fmt::format("[%D %T:%e][{}]%^[%l][%n]%$ %v (%!:%#)", serverName);

        auto createLogger = [&](std::string const& name, std::string const& pattern)
        {
            auto logger = std::make_shared<spdlog::async_logger>(name, sinks.begin(), sinks.end(), spdlog::thread_pool(), spdlog::async_overflow_policy::block);
            logger->set_pattern(pattern);
            spdlog::register_logger(logger);
            return logger;
        };

        // Create a series of loggers with different names, all sinking to the file and console sinks
        // Each name serves as the tag in the log
        // TODO: There is duplication here between the tag and the severity, FIXME

        // direct printf replacement
        auto standardLogger   = createLogger("standard", defaultPattern);
        auto messageLogger    = createLogger("message", defaultPattern);

        // To inform about good things
        auto statusLogger     = createLogger("status", defaultPattern);

        // Variable information
        auto infoLogger       = createLogger("info", defaultPattern);

        // Less than a warning
        auto noticeLogger     = createLogger("notice", defaultPattern);

        // Warnings
        auto warningLogger    = createLogger("warning", defaultPattern);

        // Important stuff
        auto debugLogger      = createLogger("debug", defaultPattern);

        // Regular errors
        auto errorLogger      = createLogger("error", defaultPattern);

        // Fatal errors, abort(); if possible
        auto fatalErrorLogger = createLogger("fatalerror", defaultPattern);

        // For dumping out anything related with SQL) <- Actually, this is mostly used for SQL errors with the database, as
        // successes can as well just be anything else...
        auto sqlLogger        = createLogger("sql", defaultPattern);

        // Lua related logging and errors
        auto luaLogger        = createLogger("lua", defaultPattern);

        // Navmesh related errors
        auto navmeshLogger    = createLogger("navmesh", defaultPattern);

        // Mostly useless "player did this" info
        auto actionLogger     = createLogger("action", defaultPattern);

        // Detected a likely exploit
        auto exploitLogger    = createLogger("exploit", defaultPattern);

        // Special format pattern for dumping stack traces
        auto stacktraceLogger = createLogger("stacktrace", fmt::format("[%D %T:%e][{}]%^[%l][%n]%$ %v", serverName));

        spdlog::set_default_logger(standardLogger);
        spdlog::flush_on(spdlog::level::warn);
        spdlog::flush_every(std::chrono::seconds(30));

        // Set default log level (everything)
        spdlog::set_level(spdlog::level::trace);
    }

    void ShutDown()
    {
        TracyZoneScoped;

        spdlog::drop_all();
        spdlog::shutdown();
    }

    void SetFilters(uint32 _filterMask)
    {
        TracyZoneScoped;

        filterMask = _filterMask;

        // TODO: Loopify this, this sucks
        if (filterMask & MSG_STANDARD)
        {
            spdlog::get("standard")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_STATUS)
        {
            spdlog::get("status")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_INFO)
        {
           spdlog::get("info")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_NOTICE)
        {
            spdlog::get("notice")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_WARNING)
        {
            spdlog::get("warning")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_DEBUG)
        {
            spdlog::get("debug")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_ERROR)
        {
            spdlog::get("error")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_FATALERROR)
        {
            spdlog::get("fatalerror")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_SQL)
        {
            spdlog::get("sql")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_LUASCRIPT)
        {
            spdlog::get("lua")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_NAVMESH)
        {
            spdlog::get("navmesh")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_ACTION)
        {
            spdlog::get("action")->set_level(spdlog::level::off);
        }

        if (filterMask & MSG_EXPLOIT)
        {
            spdlog::get("exploit")->set_level(spdlog::level::off);
        }
    }
}
