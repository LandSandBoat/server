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

#ifdef __APPLE__
#include <csignal>
#include <sys/ptrace.h>
#include <sys/resource.h>
#include <sys/sysctl.h>
#include <sys/types.h>

#ifndef PTRACE_TRACEME
#define PTRACE_TRACEME 0
#endif // PTRACE_TRACEME

#ifndef PTRACE_DETACH
#define PTRACE_DETACH 17
#endif // PTRACE_DETACH

#include "debug.h"
#include "tombstone.h"

#include <cpptrace/cpptrace.hpp>

#include <climits>
#include <crt_externs.h>
#include <cstdlib>
#include <cstring>
#include <mach-o/dyld.h>
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
        // allocating) where the platform supports it. macOS/arm64 currently does
        // not (can_signal_safe_unwind() == false), so this yields nothing there.
        if (cpptrace::can_signal_safe_unwind())
        {
            cpptrace::frame_ptr buffer[kMaxFrames];
            const std::size_t   count = cpptrace::safe_generate_raw_trace(buffer, kMaxFrames);

            cpptrace::raw_trace raw;
            raw.frames.assign(buffer, buffer + count);
            trace = raw.resolve();
        }

        // Fallback: a best-effort ordinary unwind. This is NOT async-signal-safe (it
        // allocates, and the addr2line backend may spawn atos), but the process is
        // already terminating. On platforms without signal-safe unwind it is the only
        // way to get any stack at all.
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
    static bool underDebugger    = false;

    if (!isCheckedAlready)
    {
        int mib[4] = {
            CTL_KERN,
            KERN_PROC,
            KERN_PROC_PID,
            getpid(),
        };

        kinfo_proc info{};
        info.kp_proc.p_flag = 0;

        size_t size = sizeof(info);

        if (sysctl(mib, 4, &info, &size, nullptr, 0) == 0)
        {
            underDebugger = (info.kp_proc.p_flag & P_TRACED) != 0;
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
    char     buf[PATH_MAX];
    uint32_t size = sizeof(buf);
    if (_NSGetExecutablePath(buf, &size) != 0)
    {
        return {};
    }

    char real[PATH_MAX];
    return realpath(buf, real) != nullptr ? std::string(real) : std::string(buf);
}

auto debug::commandLine() -> std::string
{
    const int    argc = *_NSGetArgc();
    char** const argv = *_NSGetArgv();

    std::string out;
    for (int i = 0; i < argc; ++i)
    {
        if (i > 0)
        {
            out += ' ';
        }
        out += argv[i];
    }
    return out;
}

#endif // __APPLE__
