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
#include "kernel.h"

#define BACKWARD_HAS_BFD 1
#include "ext/backward/backward.hpp"

// https://man7.org/linux/man-pages/man7/signal-safety.7.html
void safe_print(const char* str)
{
    // https://man7.org/linux/man-pages/man2/write.2.html
    // https://man7.org/linux/man-pages/man3/strlen.3.html
    std::ignore = write(1, str, strlen(str));
}

void dumpBacktrace(int signal)
{
    safe_print("Crash detected, generating traceback (this may take a while)\n");

    backward::StackTrace trace;
    backward::Printer    printer;

    trace.load_here(10);

    printer.object     = true;
    printer.color_mode = backward::ColorMode::always;
    printer.address    = true;

    for (auto& line : logging::GetBacktrace())
    {
        safe_print(line.c_str());
    }

    std::ostringstream traceStream;
    printer.print(trace, traceStream);
    safe_print(traceStream.str().c_str()); // This probably isn't safe?
    raise(SIGQUIT);                        // Let OS dump the core file
}

void debug::init()
{
    rlimit core_limits{};
    core_limits.rlim_cur = core_limits.rlim_max = RLIM_INFINITY;
    setrlimit(RLIMIT_CORE, &core_limits);

    // things we want to handle
    std::signal(SIGABRT, dumpBacktrace);
    std::signal(SIGSEGV, dumpBacktrace);
    std::signal(SIGFPE, dumpBacktrace);
    std::signal(SIGXFSZ, dumpBacktrace);

    // pass these onto default handler
    std::signal(SIGILL, SIG_DFL);
    std::signal(SIGBUS, SIG_DFL);
    std::signal(SIGTRAP, SIG_DFL);
}

bool debug::isRunningUnderDebugger()
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

bool debug::isUserRoot()
{
    return getuid() == 0 && getgid() == 0;
}

#endif // __linux__
