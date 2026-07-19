/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#ifdef __linux__
#include <csignal>
#include <sys/ptrace.h>
#include <sys/resource.h>
#include <sys/types.h>

#include "debug.h"
#include "tombstone.h"

#include <cpptrace/cpptrace.hpp>

#include <climits>
#include <cstring>
#include <fstream>
#include <iterator>
#include <tuple>
#include <unistd.h>

namespace
{

constexpr std::size_t kMaxFrames = 128;

constexpr auto signalName(int sig) -> const char*
{
    switch (sig)
    {
        case SIGSEGV:
            return "SIGSEGV";
        case SIGABRT:
            return "SIGABRT";
        case SIGFPE:
            return "SIGFPE";
        case SIGXFSZ:
            return "SIGXFSZ";
        default:
            return "signal";
    }
}

void crashSignalHandler(int sig)
{
    if (debug::beginCrashReport())
    {
        const char* msg = "Crash detected, writing tombstone...\n";
        std::ignore     = write(STDERR_FILENO, msg, std::strlen(msg));

        cpptrace::stacktrace trace;

        // Prefer the signal-safe unwind (capture raw return addresses without
        // allocating) where the platform supports it. Linux generally does.
        if (cpptrace::can_signal_safe_unwind())
        {
            cpptrace::frame_ptr buffer[kMaxFrames];
            const std::size_t   count = cpptrace::safe_generate_raw_trace(buffer, kMaxFrames);

            cpptrace::raw_trace raw;
            raw.frames.assign(buffer, buffer + count);
            trace = raw.resolve();
        }

        // Fallback: a best-effort ordinary unwind. This is NOT async-signal-safe (it
        // allocates, and the addr2line backend may spawn addr2line), but the process
        // is already terminating. On platforms without signal-safe unwind it is the
        // only way to get any stack at all.
        if (trace.empty())
        {
            trace = cpptrace::generate_trace();
        }

        tombstone::write({ .kind = signalName(sig), .detail = "" }, trace);
    }

    // Restore the default handler and re-raise so the OS can dump a core file.
    std::signal(sig, SIG_DFL);
    raise(sig);
}

} // namespace

void debug::init()
{
    rlimit core_limits{};
    core_limits.rlim_cur = core_limits.rlim_max = RLIM_INFINITY;
    setrlimit(RLIMIT_CORE, &core_limits);

    // Fatal signals we turn into a tombstone (then re-raise for a core dump).
    std::signal(SIGABRT, crashSignalHandler);
    std::signal(SIGSEGV, crashSignalHandler);
    std::signal(SIGFPE, crashSignalHandler);
    std::signal(SIGXFSZ, crashSignalHandler);

    // Pass these onto the default handler.
    std::signal(SIGILL, SIG_DFL);
    std::signal(SIGBUS, SIG_DFL);
    std::signal(SIGTRAP, SIG_DFL);

    // Unhandled C++ exceptions -> tombstone.
    debug::installTerminateHandler();
}

auto debug::isRunningUnderDebugger() -> bool
{
    static bool isCheckedAlready = false;

    bool underDebugger = false;

    if (!isCheckedAlready)
    {
        if (ptrace(PTRACE_TRACEME, 0, 1, 0) < 0)
        {
            underDebugger = true;
        }
        else
        {
            ptrace(PTRACE_DETACH, 0, 1, 0);
        }

        isCheckedAlready = true;
    }
    return underDebugger;
}

auto debug::isUserRoot() -> bool
{
    return getuid() == 0 && getgid() == 0;
}

auto debug::executablePath() -> std::string
{
    char          buf[PATH_MAX];
    const ssize_t len = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
    if (len <= 0)
    {
        return {};
    }

    buf[len] = '\0';
    return buf;
}

auto debug::commandLine() -> std::string
{
    // /proc/self/cmdline is the argv joined by NUL bytes (with a trailing NUL).
    std::ifstream file("/proc/self/cmdline", std::ios::binary);
    if (!file)
    {
        return {};
    }

    std::string raw((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    for (char& c : raw)
    {
        if (c == '\0')
        {
            c = ' ';
        }
    }
    while (!raw.empty() && raw.back() == ' ')
    {
        raw.pop_back();
    }
    return raw;
}

#endif // __linux__
