/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "tombstone.h"

#include "debug.h"
#include "earth_time.h"
#include "logging.h"
#include "version.h"

#include <cpptrace/cpptrace.hpp>

#include <fmt/chrono.h>
#include <fmt/format.h>

#include <chrono>
#include <cstdio>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <string_view>

#ifdef _WIN32
#include <process.h>
#define xi_getpid _getpid
#else
#include <unistd.h>
#define xi_getpid getpid
#endif

#ifndef XI_BUILD_TYPE
#define XI_BUILD_TYPE "unknown"
#endif

#define XI_TOMBSTONE_STRINGIFY2(x) #x
#define XI_TOMBSTONE_STRINGIFY(x)  XI_TOMBSTONE_STRINGIFY2(x)

namespace
{

std::chrono::steady_clock::time_point g_processStart = std::chrono::steady_clock::now();

auto localTimestamp() -> std::string
{
    // e.g. "2026/07/19 14:03:21"
    return fmt::format("{:%Y/%m/%d %H:%M:%S}", earth_time::to_local_tm());
}

auto fileTimestamp() -> std::string
{
    // filesystem-safe: no ':' or '/'
    return fmt::format("{:%Y%m%d_%H%M%S}", earth_time::to_local_tm());
}

auto uptimeString() -> std::string
{
    const auto elapsed = std::chrono::steady_clock::now() - g_processStart;
    const auto secs    = std::chrono::duration_cast<std::chrono::seconds>(elapsed).count();
    return fmt::format("{}h {}m {}s", secs / 3600, (secs % 3600) / 60, secs % 60);
}

constexpr auto compilerString() -> const char*
{
#if defined(__clang__)
    return "clang " __clang_version__;
#elif defined(__GNUC__)
    return "gcc " XI_TOMBSTONE_STRINGIFY(__GNUC__) "." XI_TOMBSTONE_STRINGIFY(__GNUC_MINOR__) "." XI_TOMBSTONE_STRINGIFY(__GNUC_PATCHLEVEL__);
#elif defined(_MSC_VER)
    return "msvc " XI_TOMBSTONE_STRINGIFY(_MSC_VER);
#else
    return "unknown compiler";
#endif
}

// Appends `text` to `buf` with every line prefixed by `indent`.
void appendIndented(fmt::memory_buffer& buf, const std::string& text, std::string_view indent)
{
    auto out         = std::back_inserter(buf);
    bool atLineStart = true;
    for (const char c : text)
    {
        if (atLineStart && c != '\n')
        {
            fmt::format_to(out, "{}", indent);
        }
        fmt::format_to(out, "{}", c);
        atLineStart = (c == '\n');
    }
    if (!text.empty() && text.back() != '\n')
    {
        fmt::format_to(out, "\n");
    }
}

constexpr std::string_view kRule   = "=====================================================";
constexpr std::string_view kThin   = "-----------------------------------------------------";
constexpr std::string_view kIndent = "    ";

} // namespace

namespace tombstone
{

void markStartTime()
{
    g_processStart = std::chrono::steady_clock::now();
}

auto build(const Reason& reason, const cpptrace::stacktrace& trace) -> std::string
{
    fmt::memory_buffer buf;
    auto               out = std::back_inserter(buf);

    const auto orUnknown = [](auto str) -> std::string
    {
        if (!str.empty())
        {
            return str;
        }

        return "<unknown>";
    };

    const std::string exePath = debug::executablePath();
    const std::string exeName = !exePath.empty() ? std::filesystem::path(exePath).filename().string() : "";
    const std::string cmdLine = debug::commandLine();

    fmt::format_to(out, "{}\n", kRule);
    fmt::format_to(out, "*** TOMBSTONE ***\n");
    fmt::format_to(out, "{}\n", kRule);
    fmt::format_to(out, "Crash reason:  {}\n", orUnknown(reason.kind));
    fmt::format_to(out, "Crash detail:  {}\n", orUnknown(reason.detail));
    fmt::format_to(out, "Crash dump:    {}\n", reason.dumpLocation.empty() ? "none" : reason.dumpLocation.c_str());
    fmt::format_to(out, "Time of crash: {}\n", localTimestamp());
    fmt::format_to(out, "Process:       pid {}\n", static_cast<long>(xi_getpid()));
    fmt::format_to(out, "Uptime:        {}\n", uptimeString());
    fmt::format_to(out, "Executable:    {}\n", orUnknown(exeName));
    fmt::format_to(out, "Path:          {}\n", orUnknown(exePath));
    fmt::format_to(out, "Command line:  {}\n", orUnknown(cmdLine));
    fmt::format_to(out, "Git:           {} ({})\n", version::GetGitBranch(), version::GetGitSha());
    fmt::format_to(out, "Build type:    {}\n", XI_BUILD_TYPE);
    fmt::format_to(out, "Compiler:      {}\n", compilerString());
#ifdef TRACY_ENABLE
    fmt::format_to(out, "Tracy:         Enabled\n");
#else
    fmt::format_to(out, "Tracy:         Disabled\n");
#endif

    fmt::format_to(out, "{}\n", kThin);
    fmt::format_to(out, "Log breadcrumb (most recent last):\n");
    const auto breadcrumb = logging::GetBacktrace();
    if (breadcrumb.empty())
    {
        fmt::format_to(out, "{}<empty>\n", kIndent);
    }
    else
    {
        for (const auto& line : breadcrumb)
        {
            fmt::format_to(out, "{}{}\n", kIndent, line);
        }
    }

    fmt::format_to(out, "{}\n", kThin);
    fmt::format_to(out, "Stack trace:\n");
    if (trace.empty())
    {
        fmt::format_to(out, "{}<no frames captured>\n", kIndent);
    }
    else
    {
        appendIndented(buf, trace.to_string(/*color=*/false), kIndent);
    }

    fmt::format_to(out, "{}\n", kRule);

    return fmt::to_string(buf);
}

auto write(const Reason& reason, const cpptrace::stacktrace& trace) -> std::string
{
    const std::string report = build(reason, trace);

    // Always surface the full report on stderr. fwrite is far more robust than the
    // logging stack in a crashing/handler context (and doesn't touch spdlog).
    std::fwrite(report.data(), 1, report.size(), stderr);
    std::fflush(stderr);

    std::string path;
    try
    {
        const std::filesystem::path dir = "dmp";
        std::filesystem::create_directories(dir);

        path = (dir / fmt::format("tombstone_{}_{}.log", static_cast<long>(xi_getpid()), fileTimestamp())).string();

        std::ofstream file(path, std::ios::out | std::ios::trunc);
        if (!file)
        {
            return {};
        }
        file << report;
    }
    catch (...)
    {
        // Filesystem can fail during a crash; the stderr copy above is the fallback.
        return {};
    }

    return path;
}

} // namespace tombstone
