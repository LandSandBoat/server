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

namespace logging
{
    void InitializeLog(std::string name, std::string logFile)
    {
        spdlog::init_thread_pool(8192, 1);

        auto stdout_sink   = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
        auto rotating_sink = std::make_shared<spdlog::sinks::rotating_file_sink_mt>(logFile, 1024 * 1024 * 10, 3);

        std::vector<spdlog::sink_ptr> sinks{ stdout_sink, rotating_sink };

        auto logger = std::make_shared<spdlog::async_logger>(name, sinks.begin(), sinks.end(), spdlog::thread_pool(), spdlog::async_overflow_policy::block);

        spdlog::set_default_logger(logger);

        // [Date Time][Logger Name][Process ID][Thread ID][Log Level] message
        spdlog::set_pattern("[%D %T][%n][P%P][T%t][%^%l%$] %v");
    }

    void ShutDown()
    {
        spdlog::shutdown();
    }

    int32 _vShowMessage(MSGTYPE type, const std::string& msg)
    {
        switch(type)
        {
            case MSG_INFORMATION:
            {
                spdlog::info(msg);
                break;
            }
            case MSG_WARNING:
            {
                spdlog::warn(msg);
                break;
            }
            case MSG_ERROR:
                [[fallthrough]];
            case MSG_FATALERROR:
            {
                spdlog::error(msg);
                break;
            }
            case MSG_NONE:
                [[fallthrough]];
            default:
            {
                spdlog::info(msg);
                break;
            }
        }
        
        return 0;
    }
}
