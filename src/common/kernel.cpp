/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/kernel.h"

#include "common/debug.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/settings.h"
#include "common/socket.h"
#include "common/taskmgr.h"
#include "common/timer.h"
#include "common/version.h"
#include "common/watchdog.h"

#include <sstream>
#if defined(__linux__) || defined(__APPLE__)
#define BACKWARD_HAS_BFD 1
#include "ext/backward/backward.hpp"
#endif

#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#ifndef _WIN32
#include <unistd.h>
#endif

#ifdef __linux__
#include <linux/version.h>
#include <sys/wait.h>
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 4, 0)
#include <sys/prctl.h>
#define HAS_YAMA_PRCTL
#endif
#endif

#ifdef TRACY_ENABLE
void* operator new(std::size_t count)
{
    void* ptr = malloc(count);
    TracyAlloc(ptr, count);
    return ptr;
}

void operator delete(void* ptr) noexcept
{
    TracyFree(ptr);
    free(ptr);
}

void operator delete(void* ptr, std::size_t count) noexcept
{
    TracyFree(ptr);
    free(ptr);
}

void operator delete[](void* ptr) noexcept
{
    TracyFree(ptr);
    free(ptr);
}

void operator delete[](void* ptr, std::size_t count) noexcept
{
    TracyFree(ptr);
    free(ptr);
}
#endif // TRACY_ENABLE

std::atomic<bool> gRunFlag = true;

std::array<std::unique_ptr<socket_data>, MAX_FD> sessions;

// This must be manually created
std::unique_ptr<ConsoleService> gConsoleService;

// Copyright (c) Athena Dev Teams
// Added by Gabuzomeu
//
// This is an implementation of signal() using sigaction() for portability.
// (sigaction() is POSIX; signal() is not.)  Taken from Stevens' _Advanced
// Programming in the UNIX Environment_.

#ifdef WIN32 // windows don't have SIGPIPE
#define SIGPIPE SIGINT
#endif

#ifndef POSIX
#define compat_signal(signo, func) signal(signo, func)
#else
sigfunc* compat_signal(int signo, sigfunc* func)
{
    sigaction sact;
    sigaction oact;

    sact.sa_handler = func;
    sigemptyset(&sact.sa_mask);
    sact.sa_flags = 0;
#ifdef SA_INTERRUPT
    sact.sa_flags |= SA_INTERRUPT; /* SunOS */
#endif

    if (sigaction(signo, &sact, &oact) < 0)
        return (SIG_ERR);

    return (oact.sa_handler);
}
#endif

/************************************************************************
 *                                                                       *
 *  CORE : Magical backtrace dump procedure (Linux + gdb)                *
 *                                                                       *
 ************************************************************************/

static void dump_backtrace() // handled in debug_osx.cpp and debug_linux.cpp
{
}

/************************************************************************
 *                                                                      *
 *  CORE : Signal Sub Function                                          *
 *                                                                      *
 ************************************************************************/

static void sig_proc(int sn)
{
    switch (sn)
    {
        case SIGINT:
        case SIGTERM:
            gRunFlag = false;
            gConsoleService->stop();
            break;
        case SIGABRT:
        case SIGSEGV:
        case SIGFPE:
            gConsoleService->stop();
            dump_backtrace();
            do_abort();
#ifdef _WIN32
#ifdef _DEBUG
            // Pass the signal to the system's default handler
            compat_signal(sn, SIG_DFL);
            raise(sn);
#endif // _DEBUG
#endif // _WIN32

            break;
#ifndef _WIN32
        case SIGXFSZ:
            // ignore and allow it to set errno to EFBIG
            ShowWarning("Max file size reached!");
            // run_flag = 0; // should we quit?
            break;
        case SIGPIPE:
            // ShowInfo ("Broken pipe found... closing socket"); // set to eof in socket.c
            break; // does nothing here
#endif
    }
}

void signals_init()
{
    compat_signal(SIGTERM, sig_proc);
    compat_signal(SIGINT, sig_proc);
#if !defined(_DEBUG) && defined(_WIN32) // need unhandled exceptions to debug on Windows
    compat_signal(SIGABRT, sig_proc);
    compat_signal(SIGSEGV, sig_proc);
    compat_signal(SIGFPE, sig_proc);
#endif
}

/************************************************************************
 *                                                                      *
 *  Warning if logged in as superuser (root)                            *
 *                                                                      *
 ************************************************************************/

void usercheck()
{
    // We _need_ root/admin for Tracy to be able to collect the full suite
    // of information, so we disable this warning if Tracy is enabled.
#ifndef TRACY_ENABLE
    if (debug::isUserRoot())
    {
        ShowWarning("You are running as the root superuser or admin.");
        ShowWarning("It is unnecessary and unsafe to run with root privileges.");
        std::this_thread::sleep_for(std::chrono::seconds(5));
    }
#endif // TRACY_ENABLE
}

/************************************************************************
 *                                                                      *
 *  CORE : MAINROUTINE                                                  *
 *                                                                      *
 ************************************************************************/
#ifndef DEFINE_OWN_MAIN
int main(int argc, char** argv)
{
    debug::init();

#ifdef _WIN32
    // Disable Quick Edit Mode (Mark) in Windows Console to prevent users from accidentially
    // causing the server to freeze.
    HANDLE hInput;
    DWORD  prev_mode;
    hInput = GetStdHandle(STD_INPUT_HANDLE);
    GetConsoleMode(hInput, &prev_mode);
    SetConsoleMode(hInput, ENABLE_EXTENDED_FLAGS | (prev_mode & ~ENABLE_QUICK_EDIT_MODE));
#endif // _WIN32

    log_init(argc, argv);
    set_socket_type();
    signals_init();
    timer_init();

    lua_init();
    settings::init();
    ShowInfo(fmt::format("Last Branch: {}", version::GetGitBranch()));
    ShowInfo(fmt::format("SHA: {} ({})", version::GetGitSha(), version::GetGitDate()));

    usercheck();

    socket_init();

    do_init(argc, argv);

    fd_set rfd = {};
    { // Main runtime cycle
        duration next = std::chrono::milliseconds(200);

        // clang-format off
        auto period   = settings::get<uint32>("main.INACTIVITY_WATCHDOG_PERIOD");
        auto periodMs = (period > 0) ? std::chrono::milliseconds(period) : 2000ms;
        auto watchdog = Watchdog(periodMs, [&]()
        {
            ShowCritical(fmt::format("Process main tick has taken {}ms or more.", period).c_str());
            if (debug::isRunningUnderDebugger())
            {
                ShowCritical("Detaching watchdog thread, it will not fire again until restart.");
            }
            else if (!settings::get<bool>("main.DISABLE_INACTIVITY_WATCHDOG"))
            {
#ifndef SIGKILL
#define SIGKILL 9
#endif // SIGKILL
                ShowCritical("Watchdog thread time exceeded. Killing process.");
                std::raise(SIGKILL);
            }
        });
        // clang-format on

        while (gRunFlag)
        {
            next = CTaskMgr::getInstance()->DoTimer(server_clock::now());
            do_sockets(&rfd, next);
            watchdog.update();
        }
    }

#ifdef _WIN32
    // Re-enable Quick Edit Mode upon Exiting if it is still disabled
    SetConsoleMode(hInput, prev_mode);
#endif // _WIN32
    gConsoleService->stop();

    do_final(EXIT_SUCCESS);
}
#endif // DEFINE_OWN_MAIN
