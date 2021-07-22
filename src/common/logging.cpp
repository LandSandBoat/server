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

#include "spdlog/common.h"
#include "spdlog/async.h"
#include "spdlog/pattern_formatter.h"
#include "spdlog/sinks/basic_file_sink.h"
#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/sinks/daily_file_sink.h"
#include "spdlog/fmt/fmt.h"
#include "spdlog/fmt/bundled/printf.h"

namespace logging
{
    void InitializeLog(std::string name, std::string logFile)
    {
        spdlog::init_thread_pool(8192, 1);

        auto stdout_sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
        auto daily_sink  = std::make_shared<spdlog::sinks::daily_file_sink_mt>(logFile, 0, 00, false, 0);

        std::vector<spdlog::sink_ptr> sinks{ stdout_sink, daily_sink };

        auto logger = std::make_shared<spdlog::async_logger>(name, sinks.begin(), sinks.end(), spdlog::thread_pool(), spdlog::async_overflow_policy::block);

        spdlog::set_default_logger(logger);

        // [date time:ms][logger name][log level] message (func_name:line_num)
        spdlog::set_pattern("[%D %T:%e][%n][%^%l%$] %v (%!:%#)");
    }

    void ShutDown()
    {
        spdlog::shutdown();
    }
}
