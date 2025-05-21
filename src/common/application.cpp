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
#include "timer.h"
#include "version.h"
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

    void handleSignal(int signal)
    {
        switch (signal)
        {
#ifdef _WIN32
            case SIGBREAK:
#endif // _WIN32
            case SIGINT:
            case SIGTERM:
                gIsRunning = false;
                std::exit(0);
                break;
            case SIGABRT:
#ifdef _WIN32
            case SIGABRT_COMPAT:
#endif // _WIN32
            case SIGSEGV:
            case SIGFPE:
            case SIGILL:
#ifdef _WIN32
#ifdef _DEBUG
                // Pass the signal to the system's default handler
                std::signal(signal, SIG_DFL);
                std::raise(signal);
#endif // _DEBUG
#endif // _WIN32
                break;
            default:
                std::cerr << fmt::format("Unhandled signal: {}\n", signal);
                break;
        }
    }

#ifdef _WIN32
    unsigned long prevQuickEditMode;
#endif // _WIN32
} // namespace

Application::Application(std::string const& serverName, int argc, char** argv)
: serverName_(serverName)
, args_(std::make_unique<Arguments>(serverName, argc, argv))
{
    prepareLogging();
    trySetConsoleTitle();
    registerSignalHandlers();
    tryDisableQuickEditMode();
    usercheck();
    tryIncreaseRLimits();

    // TODO: How much of this interferes with the signal handler in here?
    debug::init();

    lua_init();
    settings::init();

    //
    // It is safe to use the logging macros and settings from this point on
    //

    ShowInfoFmt("=======================================================================");
    ShowInfoFmt("Begin {}-server init...", serverName);

    srand(earth_time::timestamp());
    xirand::seed();

#ifdef ENV64BIT
    ShowInfo("64-bit environment detected");
#else
    ShowInfo("32-bit environment detected");
#endif

    consoleService_ = std::make_unique<ConsoleService>(*this);
}

Application::~Application()
{
    tryRestoreQuickEditMode();
}

void Application::trySetConsoleTitle()
{
#ifdef _WIN32
    SetConsoleTitleA(fmt::format("{}-server", serverName_).c_str());
#endif
}

void Application::registerSignalHandlers()
{
    // TODO: Replace with asio::signal_set

    std::signal(SIGTERM, &handleSignal);
    std::signal(SIGINT, &handleSignal);
#if !defined(_DEBUG) && defined(_WIN32) // need unhandled exceptions to debug on Windows
    std::signal(SIGBREAK, &handleSignal);
    std::signal(SIGABRT, &handleSignal);
    std::signal(SIGABRT_COMPAT, &handleSignal);
    std::signal(SIGSEGV, &handleSignal);
    std::signal(SIGFPE, &handleSignal);
    std::signal(SIGILL, &handleSignal);
#endif
#ifndef _WIN32
    std::signal(SIGXFSZ, &handleSignal);
    std::signal(SIGPIPE, &handleSignal);
#endif
}

void Application::usercheck()
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

void Application::tryDisableQuickEditMode()
{
#ifdef _WIN32
    // Disable Quick Edit Mode (Mark) in Windows Console to prevent users from accidentially
    // causing the server to freeze.
    HANDLE hInput = GetStdHandle(STD_INPUT_HANDLE);
    GetConsoleMode(hInput, &prevQuickEditMode);
    SetConsoleMode(hInput, ENABLE_EXTENDED_FLAGS | (prevQuickEditMode & ~ENABLE_QUICK_EDIT_MODE));
#endif // _WIN32
}

void Application::tryRestoreQuickEditMode()
{
#ifdef _WIN32
    // Re-enable Quick Edit Mode upon Exiting if it is still disabled
    HANDLE hInput = GetStdHandle(STD_INPUT_HANDLE);
    SetConsoleMode(hInput, prevQuickEditMode);
#endif // _WIN32
}

void Application::prepareLogging()
{
    auto logFile    = fmt::format("log/{}-server.log", serverName_);
    bool appendDate = false;

    //
    // MapServer specific setup (TODO: Move this into MapServer)
    //

    if (serverName_ == "map")
    {
        if (auto ipArg = args_->present("--ip"))
        {
            logFile = *ipArg;
        }

        if (auto portArg = args_->present("--port"))
        {
            logFile.append(*portArg);
        }
    }

    //
    // Regular setup
    //

    if (auto logArg = args_->present("--log"))
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
    loadConsoleCommands();

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

bool Application::isRunning()
{
    return gIsRunning;
}

void Application::requestExit()
{
    gIsRunning = false;
    io_context_.stop();
}

bool Application::isRunningInCI()
{
    return args_->get<bool>("--ci");
}

auto Application::ioContext() -> asio::io_context&
{
    return io_context_;
}

auto Application::args() -> Arguments&
{
    return *args_;
}

auto Application::console() -> ConsoleService&
{
    return *consoleService_;
}
