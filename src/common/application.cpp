/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "application.h"

#include "arguments.h"
#include "console_service.h"
#include "debug.h"
#include "logging.h"
#include "lua.h"
#include "settings.h"

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <timeapi.h>
#else // UNIX
#include <sys/resource.h>
#include <sys/time.h>
#endif

#include <csignal>
#include <thread>

namespace
{

#ifdef _WIN32
constexpr unsigned int kTimerResolutionMs = 1;

unsigned long prevQuickEditMode;
bool          timerResolutionRaised = false;
#endif // _WIN32

} // namespace

Application::Application(const ApplicationConfig& appConfig, int argc, char** argv)
: scheduler_()
, signals_(scheduler_.mainContext())
, serverName_(appConfig.serverName)
, args_(std::make_unique<Arguments>(appConfig, argc, argv))
{
    // Common Application initialization
    prepareLogging();
    trySetConsoleTitle();
    registerSignalHandlers();
    tryDisableQuickEditMode();
    usercheck();
    tryIncreaseRLimits();
    tryRaiseTimerResolution();
    tryPreventBackgroundThrottling();

    debug::init();

    lua_init();
    settings::init();

    //
    // It is safe to use the logging macros and settings from this point on
    //

    ShowInfoFmt("=======================================================================");
    ShowInfoFmt("Begin {}-server init...", serverName_);

#ifdef ENV64BIT
    ShowInfo("64-bit environment detected");
#else
    ShowInfo("32-bit environment detected");
#endif

    consoleService_ = std::make_unique<ConsoleService>(*this);
}

Application::~Application()
{
    tryRestoreTimerResolution();
    tryRestoreQuickEditMode();
    logging::ShutDown();
}

void Application::trySetConsoleTitle()
{
#ifdef _WIN32
    SetConsoleTitleA(fmt::format("{}-server", serverName_).c_str());
#endif
}

void Application::handleSignal(const std::error_code& error, int signal)
{
    switch (signal)
    {
#ifdef _WIN32
        case SIGBREAK:
#endif // _WIN32
        case SIGINT:
        case SIGTERM:
            // Shut down gracefully so main() unwinds and the engine's destructor runs.
            requestExit();
            break;
#ifndef _WIN32
        case SIGABRT:
        case SIGSEGV:
        case SIGFPE:
        case SIGILL:
            break;
#endif
        default:
            std::cerr << fmt::format("Unhandled signal: {}\n", signal);
            break;
    }
}

void Application::registerSignalHandlers()
{
    signals_.add(SIGINT);
    signals_.add(SIGTERM);
#ifdef _WIN32
    signals_.add(SIGBREAK);
    // Don't register crash signals with ASIO on Windows - they need to reach SEH
    // for WheatyExceptionReport to generate crash dumps
#endif
#ifndef _WIN32
    signals_.add(SIGXFSZ);
    signals_.add(SIGPIPE);
#endif
    signals_.async_wait(
        [this](const std::error_code& error, int signal)
        {
            handleSignal(error, signal);
        });
}

void Application::usercheck() const
{
#ifndef TRACY_ENABLE
    // We _need_ root/admin for Tracy to be able to collect the full suite
    // of information, so we disable this warning if Tracy is enabled.
    if (debug::isUserRoot())
    {
        std::cerr << "You are running as the root superuser or admin.\n";
        std::cerr << "It is unnecessary and unsafe to run with root privileges.\n";
        std::this_thread::sleep_for(5s);
    }
#endif // TRACY_ENABLE
}

void Application::tryIncreaseRLimits()
{
#ifndef _WIN32
    rlimit limits{};

    // Raise the soft limit to the hard limit.
    if (getrlimit(RLIMIT_NOFILE, &limits) == 0)
    {
        limits.rlim_cur = limits.rlim_max;
        if (setrlimit(RLIMIT_NOFILE, &limits) == -1)
        {
            std::cerr << fmt::format("Failed to increase rlim_cur to {}\n", static_cast<uint64>(limits.rlim_max));
        }
    }
#endif
}

void Application::tryRaiseTimerResolution()
{
#ifdef _WIN32
    // Windows' default system timer resolution is ~15.6ms, which coarsely quantises every
    // sleep and timed wait we make. Ask the OS for the finest resolution (1ms) so our
    // scheduler ticks and network timing behave predictably.
    // See: https://devblogs.microsoft.com/go/high-resolution-timers-windows/
    if (timeBeginPeriod(kTimerResolutionMs) != TIMERR_NOERROR)
    {
        std::cerr << fmt::format("Failed to raise the system timer resolution to {}ms; timing may be coarse\n", kTimerResolutionMs);
        return;
    }

    timerResolutionRaised = true;
#endif // _WIN32
}

void Application::tryRestoreTimerResolution()
{
#ifdef _WIN32
    // Balance timeBeginPeriod with a matching timeEndPeriod on the way out, but only if we
    // actually raised the resolution.
    if (timerResolutionRaised)
    {
        timeEndPeriod(kTimerResolutionMs);
        timerResolutionRaised = false;
    }
#endif // _WIN32
}

void Application::tryPreventBackgroundThrottling() const
{
#ifdef _WIN32
    // Since Windows 10, processes that aren't in the foreground can be throttled (EcoQoS),
    // deprioritising their execution speed even when we've asked for high-resolution timers.
    // Opt out so the server keeps running at full speed while backgrounded.
    PROCESS_POWER_THROTTLING_STATE powerThrottling{};
    powerThrottling.Version     = PROCESS_POWER_THROTTLING_CURRENT_VERSION;
    powerThrottling.ControlMask = PROCESS_POWER_THROTTLING_EXECUTION_SPEED;
    powerThrottling.StateMask   = 0; // 0 == throttling disabled for the masked controls

    if (!SetProcessInformation(GetCurrentProcess(), ProcessPowerThrottling, &powerThrottling, sizeof(powerThrottling)))
    {
        std::cerr << fmt::format("Failed to opt out of background execution-speed throttling (error {})\n", GetLastError());
    }
#endif // _WIN32
}

void Application::tryDisableQuickEditMode() const
{
#ifdef _WIN32
    // Disable Quick Edit Mode (Mark) in Windows Console to prevent users from accidentially
    // causing the server to freeze.
    const HANDLE hInput = GetStdHandle(STD_INPUT_HANDLE);
    GetConsoleMode(hInput, &prevQuickEditMode);
    SetConsoleMode(hInput, ENABLE_EXTENDED_FLAGS | (prevQuickEditMode & ~ENABLE_QUICK_EDIT_MODE));
#endif // _WIN32
}

void Application::tryRestoreQuickEditMode() const
{
#ifdef _WIN32
    // Re-enable Quick Edit Mode upon Exiting if it is still disabled
    const HANDLE hInput = GetStdHandle(STD_INPUT_HANDLE);
    SetConsoleMode(hInput, prevQuickEditMode);
#endif // _WIN32
}

void Application::prepareLogging()
{
    auto logFile    = fmt::format("log/{}-server.log", serverName_);
    bool appendDate = false;

    //
    // Regular setup
    //

    if (const auto logArg = args_->present("--log"))
    {
        logFile = *logArg;
    }

    if (args_->get<bool>("--append-date"))
    {
        appendDate = true;
    }

    logging::InitializeLog(serverName_, logFile, appendDate);
}

void Application::markLoaded()
{
    const auto elapsed = std::chrono::duration<double>(std::chrono::steady_clock::now() - startTime_).count();

    ShowInfoFmt("The {}-server is ready to work after {:.2f} seconds...", serverName_, elapsed);
    ShowInfoFmt("Type 'help' for a list of available commands.");
    ShowInfoFmt("=======================================================================");

    if (Application::isRunningInCI())
    {
        ShowInfo("CI mode enabled: exiting after successful initialization");
        std::exit(0);
    }
}

auto Application::isRunning() const -> bool
{
    return !scheduler_.closeRequested();
}

void Application::requestExit()
{
    scheduler_.postToMainThread(
        [this]()
        {
            scheduler_.stop();
        });
}

auto Application::closeRequested() const -> bool
{
    return scheduler_.closeRequested();
}

auto Application::isRunningInCI() const -> bool
{
    return args_->get<bool>("--ci");
}

auto Application::run() -> bool
{
    ShowInfo("Creating engine");
    engine_ = createEngine();

    if (engine_)
    {
        ShowInfo("Initializing engine");
        engine_->onInitialize();

        // Register specialized commands
        registerCommands(console());
    }

    markLoaded();

    // NOTE: scheduler_.run() takes over and blocks this thread. Anything after this point will only fire
    // if scheduler_ finishes!
    //
    // https://think-async.com/asio/asio-1.24.0/doc/asio/reference/io_service.html
    //
    // If an exception is thrown from a handler, the exception is allowed to propagate through the throwing thread's invocation of
    // run(), run_one(), run_for(), run_until(), poll() or poll_one(). No other threads that are calling any of these functions are affected.
    // It is then the responsibility of the application to catch the exception.

    while (isRunning())
    {
        try
        {
            scheduler_.run();
            break;
        }
        catch (std::exception& e)
        {
            ShowErrorFmt("Fatal exception: {}", e.what());
            return false;
        }
    }

    return true;
}

auto Application::scheduler() -> Scheduler&
{
    return scheduler_;
}

auto Application::zmqService() -> ZMQService&
{
    return zmqService_;
}

auto Application::args() const -> Arguments&
{
    return *args_;
}

auto Application::console() const -> ConsoleService&
{
    return *consoleService_;
}
