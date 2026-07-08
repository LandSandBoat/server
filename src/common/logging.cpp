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

#include "application.h"
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

#include <array>
#include <cctype>

namespace
{

std::string ServerName;

CircularBuffer<std::string> BacktraceBuffer(32);

bool gSeenWarningOrError = false;

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
        static constexpr std::size_t length = 32;

        const std::string locationStr = fmt::format("{}:{}", msg.source.funcname, msg.source.line);
        const std::string outStr      = locationStr.size() > length ? std::string(locationStr.end() - length, locationStr.end()) : fmt::format("{:>{}}", locationStr, length);
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
        // Append directly; no need to copy ServerName into a temporary first.
        dest.append(ServerName.data(), ServerName.data() + ServerName.size());
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
        if (ServerName.empty())
        {
            return;
        }

        const char initial = static_cast<char>(std::toupper(static_cast<unsigned char>(ServerName[0])));
        dest.append(&initial, &initial + 1);
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
        static constexpr std::size_t length = 32;

        const std::string locationStr = fmt::format("{}:{}", msg.source.filename, msg.source.line);
        const std::string outStr      = locationStr.size() > length ? std::string(locationStr.end() - length, locationStr.end()) : fmt::format("{:>{}}", locationStr, length);
        dest.append(outStr.data(), outStr.data() + outStr.size());
    }

    std::unique_ptr<custom_flag_formatter> clone() const override
    {
        return spdlog::details::make_unique<q_formatter_flag>();
    }
};

constexpr std::array<std::string_view, 7> logNames = {
    "critical",
    "error",
    "lua",
    "warn",
    "info",
    "debug",
    "trace",
};

// Non-owning pointers to the loggers registered under logNames, in the same order.
// Populated once in InitializeLog (before any worker threads exist) and only read
// afterward, so loggerFor() needs no synchronization. The registry owns the loggers.
std::array<spdlog::logger*, logNames.size()> logPointers{};

void logging::InitializeLog(const std::string& serverName, const std::string& logFile, bool appendDate)
{
    ServerName = serverName;

    // If you create more than one worker thread, messages may be delivered out of order
    spdlog::init_thread_pool(8192, 1);
    spdlog::flush_on(spdlog::level::warn);
    spdlog::flush_every(5s);

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

    for (std::size_t i = 0; i < logNames.size(); ++i)
    {
        auto logger = std::make_shared<spdlog::async_logger>(std::string(logNames[i]), sinks.begin(), sinks.end(), spdlog::thread_pool());
        spdlog::register_logger(logger);
    }

    logging::RefreshLoggerCache();

    spdlog::set_level(spdlog::level::debug);
}

void logging::ShutDown()
{
    spdlog::drop_all();
    spdlog::shutdown();
}

void logging::SetPattern(const std::string& str)
{
    detail::gJsonMode = settings::get<bool>("logging.JSON_ENABLED");
    if (detail::gJsonMode)
    {
        spdlog::set_pattern("%v");
        return;
    }

    // https://github.com/gabime/spdlog/wiki/3.-Custom-formatting
    auto formatter = std::make_unique<spdlog::pattern_formatter>();
    formatter->add_flag<star_formatter_flag>('*');
    formatter->add_flag<ampersand_formatter_flag>('&');
    formatter->add_flag<underscore_formatter_flag>('_');
    formatter->add_flag<q_formatter_flag>('q');
    formatter->set_pattern(str);
    spdlog::set_formatter(std::move(formatter));
}

void logging::RefreshLoggerCache()
{
    for (std::size_t i = 0; i < logNames.size(); ++i)
    {
        const auto logger = spdlog::get(std::string(logNames[i]));
        logPointers[i]    = logger.get();
    }
}

auto logging::loggerFor(std::string_view name) -> spdlog::logger*
{
    for (std::size_t i = 0; i < logNames.size(); ++i)
    {
        if (logNames[i] == name)
        {
            return logPointers[i];
        }
    }

    // Fallback for the (pre-init) edge case: pay the one-off registry lookup.
    const auto logger = spdlog::get(std::string(name));
    return logger.get();
}

void logging::AddBacktrace(const std::string& str)
{
    BacktraceBuffer.enqueue(str);
}

void logging::AddBacktrace(std::string&& str)
{
    BacktraceBuffer.enqueue(std::move(str));
}

auto logging::GetBacktrace() -> std::vector<std::string>
{
    std::vector<std::string> backtrace;

    // Emptying in this manner will mean the oldest is returned first, and the most recent is returned last
    while (!BacktraceBuffer.is_empty())
    {
        backtrace.push_back(BacktraceBuffer.dequeue());
    }

    return backtrace;
}

void logging::tapWarningOrError()
{
    gSeenWarningOrError = true;
}
