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
#include <sys/resource.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <sys/ucontext.h>

#include <common/debug.h>
#include <common/tombstone.h>

#include <cpptrace/cpptrace.hpp>

#include <atomic>
#include <climits>
#include <crt_externs.h>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <mach-o/dyld.h>
#include <pthread.h>
#include <tuple>
#include <unistd.h>
#include <vector>

namespace
{

constexpr std::size_t kMaxFrames = 128;

// State for capturing the main thread's stack from another thread on request.
pthread_t           mainThread{};
std::atomic<bool>   mainThreadRegistered{ false };
std::atomic<bool>   mainStackCaptured{ false };
cpptrace::raw_trace mainThreadRaw; // written by captureMainStackHandler, read after mainStackCaptured

// Walks frame pointers from a signal's ucontext to recover the interrupted thread's real
// stack. macOS's unwinder cannot cross the signal trampoline (an ordinary unwind from a
// handler misses the leaf frames and shows handler noise), but frame pointers are always
// present here, so this gives the true stack starting at the interrupted instruction.
auto framesFromContext(void* ucontextRaw) -> std::vector<cpptrace::frame_ptr>
{
    std::vector<cpptrace::frame_ptr> frames;

    const auto uc = static_cast<const ucontext_t*>(ucontextRaw);
    if (uc == nullptr)
    {
        return frames;
    }

    const auto& ss = uc->uc_mcontext->__ss;
#if defined(__arm64__) || defined(__aarch64__)
    auto fp = static_cast<std::uintptr_t>(ss.__fp);
    frames.push_back(static_cast<std::uintptr_t>(ss.__pc));
#else // __x86_64__
    auto fp = static_cast<std::uintptr_t>(ss.__rbp);
    frames.push_back(static_cast<std::uintptr_t>(ss.__rip));
#endif

    for (std::size_t i = 0; i < kMaxFrames && fp != 0; ++i)
    {
        const auto record = reinterpret_cast<const std::uintptr_t*>(fp);
        const auto nextFp = record[0];
        const auto ret    = record[1];
        if (ret == 0)
        {
            break;
        }
        frames.push_back(ret);
        if (nextFp <= fp) // guard against a corrupt / non-monotonic chain
        {
            break;
        }
        fp = nextFp;
    }
    return frames;
}

// Runs on the main thread when it receives SIGUSR2 from captureMainThreadTrace().
void captureMainStackHandler(int, siginfo_t*, void* ucontext)
{
    mainThreadRaw.frames = framesFromContext(ucontext);
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

void crashSignalHandler(int sig, siginfo_t*, void* ucontext)
{
    if (debug::beginCrashReport())
    {
        const auto msg = "Crash detected, writing tombstone...\n";
        std::ignore    = write(STDERR_FILENO, msg, std::strlen(msg));

        // Unwind from the signal ucontext (frame-pointer walk) so we get the real fault
        // frame rather than this handler and the trampoline. Symbolization here is NOT
        // async-signal-safe (it allocates and may spawn atos), but the process is already
        // terminating. Fall back to an ordinary unwind if the frame walk comes up empty.
        cpptrace::raw_trace raw;
        raw.frames = framesFromContext(ucontext);

        auto trace = raw.resolve();
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

    // Fatal signals we turn into a tombstone (then re-raise for a core dump). SA_SIGINFO
    // hands the handler the ucontext, so we can unwind the actual fault stack across the
    // signal trampoline.
    struct sigaction action{};
    action.sa_sigaction = crashSignalHandler;
    action.sa_flags     = SA_SIGINFO;
    sigemptyset(&action.sa_mask);
    sigaction(SIGABRT, &action, nullptr);
    sigaction(SIGSEGV, &action, nullptr);
    sigaction(SIGFPE, &action, nullptr);
    sigaction(SIGXFSZ, &action, nullptr);

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

auto debug::processId() -> int
{
    return getpid();
}

auto debug::executablePath() -> Maybe<std::string>
{
    char     buf[PATH_MAX];
    uint32_t size = sizeof(buf);
    if (_NSGetExecutablePath(buf, &size) != 0)
    {
        return std::nullopt;
    }

    char real[PATH_MAX];
    if (realpath(buf, real) != nullptr)
    {
        return std::string(real);
    }
    return std::string(buf);
}

auto debug::commandLine() -> Maybe<std::string>
{
    const auto argc = *_NSGetArgc();
    const auto argv = *_NSGetArgv();
    if (argc <= 0)
    {
        return std::nullopt;
    }

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

auto debug::coreDumpHint() -> Maybe<std::string>
{
    // macOS writes cores to /cores/core.<pid> when enabled (we raise RLIMIT_CORE in
    // init, but the /cores directory must also exist and be writable).
    return "/cores/core." + std::to_string(getpid()) + " (if core dumps are enabled)";
}

void debug::registerMainThread()
{
    mainThread = pthread_self();

    // SA_SIGINFO so captureMainStackHandler receives the ucontext to unwind from.
    struct sigaction action{};
    action.sa_sigaction = captureMainStackHandler;
    action.sa_flags     = SA_SIGINFO;
    sigemptyset(&action.sa_mask);
    sigaction(SIGUSR2, &action, nullptr);

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

#endif // __APPLE__
