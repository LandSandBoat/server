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
#include "task_manager.h"
#include "xirand.h"

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else // UNIX
#include <sys/resource.h>
#include <sys/time.h>
#endif

#include <csignal>

namespace
{
    // Marked as true by markLoaded() when the
    // application is fully loaded and the main
    // loop has begun.
    bool gIsRunning = false;

    void handleSignal(const std::error_code& error, int signal)
    {
        if (error)
        {
            return;
        }

        switch (signal)
        {
#ifdef _WIN32
            case SIGBREAK:
#endif // _WIN32
            case SIGINT:
            case SIGTERM:
                gIsRunning = false;
                std::exit(0);
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

#ifdef _WIN32
    unsigned long prevQuickEditMode;
#endif // _WIN32
} // namespace

Application::Application(const ApplicationConfig& appConfig, int argc, char** argv)
: signals_(io_context_)
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
    signals_.cancel();
    tryRestoreQuickEditMode();
    logging::ShutDown();
}

void Application::trySetConsoleTitle()
{
#ifdef _WIN32
    SetConsoleTitleA(fmt::format("{}-server", serverName_).c_str());
#endif
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
    signals_.async_wait(&handleSignal);
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

    uint32 newRLimit = 10240;

    // Get old limits
    if (getrlimit(RLIMIT_NOFILE, &limits) == 0)
    {
        // Increase open file limit, which includes sockets, to newRLimit. This only effects the current process and child processes
        limits.rlim_cur = newRLimit;
        if (setrlimit(RLIMIT_NOFILE, &limits) == -1)
        {
            std::cerr << fmt::format("Failed to increase rlim_cur to {}\n", newRLimit);
        }
    }
#endif
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
    ShowInfoFmt("The {}-server is ready to work...", serverName_);
    ShowInfoFmt("Type 'help' for a list of available commands.");
    ShowInfoFmt("=======================================================================");
    gIsRunning = true;

    if (Application::isRunningInCI())
    {
        ShowInfo("CI mode enabled: exiting after successful initialization");
        std::exit(0);
    }
}

auto Application::isRunning() const -> bool
{
    return gIsRunning;
}

void Application::requestExit()
{
    gIsRunning = false;
}

auto Application::isRunningInCI() const -> bool
{
    return args_->get<bool>("--ci");
}

void Application::run()
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

    try
    {
        // NOTE: io_context_.run() takes over and blocks this thread. Anything after this point will only fire
        // if io_context_ finishes!
        //
        // This busy loop looks nasty, however --
        // https://think-async.com/Asio/asio-1.24.0/doc/asio/reference/io_service.html
        //
        // If an exception is thrown from a handler, the exception is allowed to propagate through the throwing thread's invocation of
        // run(), run_one(), run_for(), run_until(), poll() or poll_one(). No other threads that are calling any of these functions are affected.
        // It is then the responsibility of the application to catch the exception.

        while (isRunning())
        {
            try
            {
                io_context_.run();
                break;
            }
            catch (std::exception& e)
            {
                // TODO: make a list of "allowed exceptions", the rest can/should cause shutdown.
                ShowErrorFmt("Inner fatal: {}", e.what());
            }
        }
    }
    catch (std::exception& e)
    {
        ShowErrorFmt("Outer fatal: {}", e.what());
    }
}

auto Application::ioContext() -> asio::io_context&
{
    return io_context_;
}

auto Application::args() const -> Arguments&
{
    return *args_;
}

auto Application::console() const -> ConsoleService&
{
    return *consoleService_;
}
