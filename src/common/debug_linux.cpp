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
#include <sys/resource.h>
#include <sys/types.h>

#include <common/debug.h>
#include <common/tombstone.h>

#include <cpptrace/cpptrace.hpp>

#include <atomic>
#include <charconv>
#include <climits>
#include <cstring>
#include <ctime>
#include <fstream>
#include <iterator>
#include <pthread.h>
#include <string_view>
#include <tuple>
#include <unistd.h>

namespace
{

constexpr std::size_t kMaxFrames = 128;

// State for capturing the main thread's stack from another thread on request.
pthread_t           mainThread{};
std::atomic<bool>   mainThreadRegistered{ false };
std::atomic<bool>   mainStackCaptured{ false };
cpptrace::raw_trace mainThreadRaw; // written by captureMainStackHandler, read after mainStackCaptured

// Runs on the main thread when it receives SIGUSR2 from captureMainThreadTrace().
void captureMainStackHandler(int)
{
    mainThreadRaw = cpptrace::generate_raw_trace();
    mainStackCaptured.store(true, std::memory_order_release);
}

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
        const auto msg = "Crash detected, writing tombstone...\n";
        std::ignore    = write(STDERR_FILENO, msg, std::strlen(msg));

        cpptrace::stacktrace trace;

        // Prefer the signal-safe unwind (capture raw return addresses without
        // allocating) where the platform supports it. Linux generally does.
        if (cpptrace::can_signal_safe_unwind())
        {
            cpptrace::frame_ptr buffer[kMaxFrames];
            const auto          count = cpptrace::safe_generate_raw_trace(buffer, kMaxFrames);

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

        // captureMainThreadTrace() grabs the main thread's stack when the crash is off
        // the main thread (nullopt otherwise, so no second stack is printed).
        tombstone::write({ .kind = signalName(sig), .dumpLocation = debug::coreDumpHint() },
                         trace,
                         debug::captureMainThreadTrace());
    }

    // Restore the default handler and re-raise so the OS can dump a core file.
    std::signal(sig, SIG_DFL);
    raise(sig);
}

} // namespace

void debug::init()
{
    debug::registerMainThread();

    // Fatal signals we turn into a tombstone (then re-raise so the process still dies with the
    // signal, dumping a core only if core dumps were opted in).
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

void debug::setCoreDumpsEnabled(bool enabled)
{
    rlimit lim{};
    if (getrlimit(RLIMIT_CORE, &lim) != 0)
    {
        return;
    }
    lim.rlim_cur = enabled ? lim.rlim_max : 0;
    setrlimit(RLIMIT_CORE, &lim);
}

auto debug::isRunningUnderDebugger() -> bool
{
    static bool isCheckedAlready = false;
    static bool underDebugger    = false;

    if (!isCheckedAlready)
    {
        std::ifstream file("/proc/self/status");
        std::string   line;
        while (std::getline(file, line))
        {
            constexpr auto key = std::string_view("TracerPid:");
            if (line.starts_with(key))
            {
                auto value = std::string_view(line).substr(key.size());
                if (const auto start = value.find_first_not_of(" \t"); start != std::string_view::npos)
                {
                    value = value.substr(start);

                    int pid = 0;
                    if (std::from_chars(value.data(), value.data() + value.size(), pid).ec == std::errc())
                    {
                        underDebugger = pid != 0;
                    }
                }
                break;
            }
        }

        isCheckedAlready = true;
    }
    return underDebugger;
}

auto debug::isUserRoot() -> bool
{
    return getuid() == 0 && getgid() == 0;
}

auto debug::processId() -> int
{
    return getpid();
}

auto debug::executablePath() -> Maybe<std::string>
{
    char       buf[PATH_MAX];
    const auto len = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
    if (len <= 0)
    {
        return std::nullopt;
    }

    buf[len] = '\0';
    return std::string(buf);
}

auto debug::commandLine() -> Maybe<std::string>
{
    // /proc/self/cmdline is the argv joined by NUL bytes (with a trailing NUL).
    std::ifstream file("/proc/self/cmdline", std::ios::binary);
    if (!file)
    {
        return std::nullopt;
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

    if (raw.empty())
    {
        return std::nullopt;
    }

    return raw;
}

auto debug::coreDumpHint() -> Maybe<std::string>
{
    std::ifstream file("/proc/sys/kernel/core_pattern");
    std::string   pattern;
    if (file)
    {
        std::getline(file, pattern);
    }

    if (pattern.empty())
    {
        return std::nullopt;
    }

    // A leading '|' means the core is piped to a userspace handler rather than written
    // to a file (systemd-coredump, apport, ...).
    if (pattern.front() == '|')
    {
        if (pattern.find("systemd-coredump") != std::string::npos)
        {
            return "handled by systemd-coredump (retrieve with: coredumpctl dump " + std::to_string(getpid()) + ")";
        }
        return "piped to core handler:" + pattern.substr(1);
    }

    return "core_pattern: " + pattern + " (relative paths land in the server's working directory)";
}

void debug::registerMainThread()
{
    mainThread = pthread_self();
    std::signal(SIGUSR2, captureMainStackHandler);
    mainThreadRegistered.store(true, std::memory_order_release);
}

auto debug::captureMainThreadTrace() -> Maybe<cpptrace::stacktrace>
{
    if (!mainThreadRegistered.load(std::memory_order_acquire) ||
        pthread_equal(pthread_self(), mainThread))
    {
        return std::nullopt;
    }

    // Ask the main thread to capture its own stack (captureMainStackHandler), then wait
    // a bounded time for it. If it never responds (signals blocked, wedged in the kernel)
    // we give up rather than hang the crash path.
    mainStackCaptured.store(false, std::memory_order_release);
    if (pthread_kill(mainThread, SIGUSR2) != 0)
    {
        return std::nullopt;
    }

    for (int i = 0; i < 1000 && !mainStackCaptured.load(std::memory_order_acquire); ++i)
    {
        timespec ts{ .tv_sec = 0, .tv_nsec = 1'000'000 }; // 1ms, up to ~1s total
        nanosleep(&ts, nullptr);
    }

    if (!mainStackCaptured.load(std::memory_order_acquire))
    {
        return std::nullopt;
    }

    auto stack = mainThreadRaw.resolve();
    if (stack.empty())
    {
        return std::nullopt;
    }

    return stack;
}

#endif // __linux__
