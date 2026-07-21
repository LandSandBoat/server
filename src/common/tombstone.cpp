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

#include <common/tombstone.h>

#include <common/debug.h>
#include <common/earth_time.h>
#include <common/logging.h>
#include <common/macros.h>
#include <common/version.h>

#include <cpptrace/cpptrace.hpp>
#include <cpptrace/formatting.hpp>

#include <fmt/chrono.h>
#include <fmt/format.h>

#include <chrono>
#include <cstdio>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <string_view>

namespace
{

auto processStart = std::chrono::steady_clock::now();

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
    const auto elapsed = std::chrono::steady_clock::now() - processStart;
    const auto secs    = std::chrono::duration_cast<std::chrono::seconds>(elapsed).count();
    return fmt::format("{}h {}m {}s", secs / 3600, (secs % 3600) / 60, secs % 60);
}

constexpr auto compilerString() -> const char*
{
#if defined(__clang__)
    return "Clang " __clang_version__;
#elif defined(__GNUC__)
    // cppcheck-suppress unknownMacro
    return "GCC " XI_STRINGIFY(__GNUC__) "." XI_STRINGIFY(__GNUC_MINOR__) "." XI_STRINGIFY(__GNUC_PATCHLEVEL__);
#elif defined(_MSC_VER)
    // cppcheck-suppress unknownMacro
    return "MSVC " XI_STRINGIFY(_MSC_VER);
#else
    return "Unknown";
#endif
}

auto traceFormatter() -> const cpptrace::formatter&
{
    static const auto formatter = cpptrace::formatter{}
                                      .header("")
                                      .symbols(cpptrace::formatter::symbol_mode::pruned);
    return formatter;
}

// Appends `text` to `buf` with every line prefixed by `indent`.
void appendIndented(fmt::memory_buffer& buf, const std::string& text, std::string_view indent)
{
    const auto out         = std::back_inserter(buf);
    bool       atLineStart = true;
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
    processStart = std::chrono::steady_clock::now();
}

auto build(const Reason& reason, const cpptrace::stacktrace& trace, const Maybe<cpptrace::stacktrace>& mainThreadTrace) -> std::string
{
    fmt::memory_buffer buf;
    const auto         out = std::back_inserter(buf);

    const auto exePath = debug::executablePath();
    const auto cmdLine = debug::commandLine();

    Maybe<std::string> exeName;
    if (exePath)
    {
        exeName = std::filesystem::path(*exePath).filename().string();
    }

    fmt::format_to(out, "{}\n", kRule);
    fmt::format_to(out, "*** TOMBSTONE ***\n");
    fmt::format_to(out, "{}\n", kRule);
    fmt::format_to(out, "Crash reason:  {}\n", reason.kind);
    fmt::format_to(out, "Crash detail:  {}\n", reason.detail.value_or("<unknown>"));
    fmt::format_to(out, "Crash dump:    {}\n", reason.dumpLocation.value_or("none"));
    fmt::format_to(out, "Time of crash: {}\n", localTimestamp());
    fmt::format_to(out, "Process:       pid {}\n", debug::processId());
    fmt::format_to(out, "Uptime:        {}\n", uptimeString());
    fmt::format_to(out, "Executable:    {}\n", exeName.value_or("<unknown>"));
    fmt::format_to(out, "Path:          {}\n", exePath.value_or("<unknown>"));
    fmt::format_to(out, "Command line:  {}\n", cmdLine.value_or("<unknown>"));
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
    if (mainThreadTrace)
    {
        fmt::format_to(out, "Stack trace (crashing thread):\n");
    }
    else
    {
        fmt::format_to(out, "Stack trace:\n");
    }

    if (trace.empty())
    {
        fmt::format_to(out, "{}<no frames captured>\n", kIndent);
    }
    else
    {
        appendIndented(buf, traceFormatter().format(trace), kIndent);
    }

    if (mainThreadTrace)
    {
        fmt::format_to(out, "{}\n", kThin);
        fmt::format_to(out, "Stack trace (main thread):\n");
        appendIndented(buf, traceFormatter().format(*mainThreadTrace), kIndent);
    }

    fmt::format_to(out, "{}\n", kRule);

    return fmt::to_string(buf);
}

auto write(const Reason& reason, const cpptrace::stacktrace& trace, const Maybe<cpptrace::stacktrace>& mainThreadTrace) -> std::string
{
    const auto report = build(reason, trace, mainThreadTrace);

    // Always surface the full report on stderr. fwrite is far more robust than the
    // logging stack in a crashing/handler context (and doesn't touch spdlog).
    std::fwrite(report.data(), 1, report.size(), stderr);
    std::fflush(stderr);

    std::string path;
    try
    {
        const auto dir = std::filesystem::path("dmp");
        std::filesystem::create_directories(dir);

        path = (dir / fmt::format("tombstone_{}_{}.log", debug::processId(), fileTimestamp())).string();

        auto file = std::ofstream(path, std::ios::out | std::ios::trunc);
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
