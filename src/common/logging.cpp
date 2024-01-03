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

#include "circular_buffer.h"

#include "spdlog/common.h"

#include "spdlog/async.h"
#include "spdlog/pattern_formatter.h"
#include "spdlog/sinks/basic_file_sink.h"
#include "spdlog/sinks/daily_file_sink.h"
#include "spdlog/sinks/stdout_color_sinks.h"

namespace
{
    std::string ServerName;

    CircularBuffer<std::string> BacktraceBuffer(16);
} // namespace

class star_formatter_flag : public spdlog::custom_flag_formatter
{
public:
    void format(const spdlog::details::log_msg& msg, const std::tm&, spdlog::memory_buf_t& dest) override
    {
        // spdlog and libfmt don't appear to have functionality to truncate text leaving the contents
        // on the right, so we have to do it by hand.
        // If longer than length, we pad, if less, then we build a new string of size length.
        // https://fmt.dev/latest/syntax.html
        std::size_t length      = 32;
        std::string locationStr = fmt::format("{}:{}", msg.source.funcname, msg.source.line);
        std::string outStr      = locationStr.size() > length ? std::string(locationStr.end() - length, locationStr.end()) : fmt::format("{:>{}}", locationStr, length);
        dest.append(outStr.data(), outStr.data() + outStr.size());
    }

    std::unique_ptr<custom_flag_formatter> clone() const override
    {
        return spdlog::details::make_unique<star_formatter_flag>();
    }
};

class ampersand_formatter_flag : public spdlog::custom_flag_formatter
{
public:
    void format(const spdlog::details::log_msg&, const std::tm&, spdlog::memory_buf_t& dest) override
    {
        std::string outStr = ServerName;
        dest.append(outStr.data(), outStr.data() + outStr.size());
    }

    std::unique_ptr<custom_flag_formatter> clone() const override
    {
        return spdlog::details::make_unique<ampersand_formatter_flag>();
    }
};

class underscore_formatter_flag : public spdlog::custom_flag_formatter
{
public:
    void format(const spdlog::details::log_msg&, const std::tm&, spdlog::memory_buf_t& dest) override
    {
        std::string firstChar = std::string(1, ServerName[0]);
        std::string outStr    = to_upper(firstChar);
        dest.append(outStr.data(), outStr.data() + outStr.size());
    }

    std::unique_ptr<custom_flag_formatter> clone() const override
    {
        return spdlog::details::make_unique<underscore_formatter_flag>();
    }
};

class q_formatter_flag : public spdlog::custom_flag_formatter
{
public:
    void format(const spdlog::details::log_msg& msg, const std::tm&, spdlog::memory_buf_t& dest) override
    {
        // spdlog and libfmt don't appear to have functionality to truncate text leaving the contents
        // on the right, so we have to do it by hand.
        // If longer than length, we pad, if less, then we build a new string of size length.
        // https://fmt.dev/latest/syntax.html
        std::size_t length      = 32;
        std::string locationStr = fmt::format("{}:{}", msg.source.filename, msg.source.line);
        std::string outStr      = locationStr.size() > 12 ? std::string(locationStr.end() - length, locationStr.end()) : fmt::format("{:>{}}", locationStr, length);
        dest.append(outStr.data(), outStr.data() + outStr.size());
    }

    std::unique_ptr<custom_flag_formatter> clone() const override
    {
        return spdlog::details::make_unique<q_formatter_flag>();
    }
};

namespace logging
{
    const std::vector<std::string> logNames = {
        "critical",
        "error",
        "lua",
        "warn",
        "info",
        "debug",
        "trace",
    };

    void InitializeLog(std::string const& serverName, std::string const& logFile, bool appendDate)
    {
        ServerName = serverName;

        // If you create more than one worker thread, messages may be delivered out of order
        spdlog::init_thread_pool(8192, 1);
        spdlog::flush_on(spdlog::level::warn);
        spdlog::flush_every(std::chrono::seconds(5));

        // Sink to console
        std::vector<spdlog::sink_ptr> sinks;
        sinks.emplace_back(std::make_shared<spdlog::sinks::stdout_color_sink_mt>());

        // Daily Sink, creating new files at midnight
        if (appendDate)
        {
            sinks.emplace_back(std::make_shared<spdlog::sinks::daily_file_sink_mt>(logFile, 0, 0, false, 0));
        }
        // Basic sink, sink to file with name specified in main routine
        else
        {
            sinks.emplace_back(std::make_shared<spdlog::sinks::basic_file_sink_mt>(logFile));
        }

        for (auto& name : logNames)
        {
            auto logger = std::make_shared<spdlog::async_logger>(name, sinks.begin(), sinks.end(), spdlog::thread_pool());
            spdlog::register_logger(logger);
        }

        spdlog::set_level(spdlog::level::debug);

        spdlog::enable_backtrace(16);
    }

    void ShutDown()
    {
        spdlog::drop_all();
        spdlog::shutdown();
    }

    void SetPattern(std::string const& str)
    {
        // https://github.com/gabime/spdlog/wiki/3.-Custom-formatting
        auto formatter = std::make_unique<spdlog::pattern_formatter>();
        formatter->add_flag<star_formatter_flag>('*');
        formatter->add_flag<ampersand_formatter_flag>('&');
        formatter->add_flag<underscore_formatter_flag>('_');
        formatter->add_flag<q_formatter_flag>('q');
        formatter->set_pattern(str);
        spdlog::set_formatter(std::move(formatter));
    }

    void AddBacktrace(std::string const& str)
    {
        if (BacktraceBuffer.is_full())
        {
            BacktraceBuffer.dequeue();
        }

        BacktraceBuffer.enqueue(str);
    }

    auto GetBacktrace() -> std::vector<std::string>
    {
        std::vector<std::string> backtrace;

        while (!BacktraceBuffer.is_empty())
        {
            backtrace.push_back(BacktraceBuffer.dequeue());
        }

        return backtrace;
    }
} // namespace logging
