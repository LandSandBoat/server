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
#include "settings.h"
#include "tracy.h"
#include "utils.h"

#include "spdlog/common.h"

#include "spdlog/async.h"
#include "spdlog/pattern_formatter.h"
#include "spdlog/sinks/basic_file_sink.h"
#include "spdlog/sinks/daily_file_sink.h"
#include "spdlog/sinks/stdout_color_sinks.h"

namespace logging
{
    const std::vector<std::string> logNames =
    {
        "critical", "error", "warn", "info", "debug", "trace",
    };

    void InitializeLog(std::string serverName, std::string logFile, bool appendDate)
    {
        TracyZoneScoped;

        // If you create more than one worker thread, messages may be delivered out of order
        spdlog::init_thread_pool(8192, 1);
        spdlog::flush_on(spdlog::level::warn);
        spdlog::flush_every(std::chrono::seconds(5));

        // Sink to console
        std::vector<spdlog::sink_ptr> sinks;
        sinks.push_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());

        // Daily Sink, creating new files at midnight
        if (appendDate)
        {
            sinks.push_back(std::make_shared<spdlog::sinks::daily_file_sink_mt>(logFile, 0, 0, false, 0));
        }
        // Basic sink, sink to file with name specified in main routine
        else
        {
            sinks.push_back(std::make_shared<spdlog::sinks::basic_file_sink_mt>(logFile));
        }

        for (auto& name : logNames)
        {
            auto logger = std::make_shared<spdlog::async_logger>(name, sinks.begin(), sinks.end(), spdlog::thread_pool());
            spdlog::register_logger(logger);
        }

        // https://github.com/gabime/spdlog/wiki/3.-Custom-formatting
        // [date time:ms][server name][log level] message (func_name:func_line)
        //                            ^level col^
        spdlog::set_pattern(fmt::format("[%D %T:%e][{}]%^[%l]%$ %v (%!:%#)", serverName));

#ifdef _DEBUG
        spdlog::set_level(spdlog::level::debug);
#else
        spdlog::set_level(spdlog::level::info);
#endif

        spdlog::enable_backtrace(10);
    }

    void ShutDown()
    {
        TracyZoneScoped;

        spdlog::drop_all();
        spdlog::shutdown();
    }
} // namespace logging
