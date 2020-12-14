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

#include "../common/kernel.h"
#include "../common/showmsg.h"
#include "../common/socket.h"
#include "../common/taskmgr.h"
#include "../common/timer.h"
#include "../common/version.h"

#include "fmt/printf.h"
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

int    runflag = 1;
int    arg_c   = 0;
char** arg_v   = nullptr;

char* SERVER_NAME = nullptr;
char  SERVER_TYPE = TOPAZ_SERVER_NONE;

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
    struct sigaction sact, oact;

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
 *  CORE : Magical backtrace dump procedure                              *
 *                                                                       *
 ************************************************************************/

static void dump_backtrace()
{
    // gdb
#if defined(__linux__)
    int fd[2];
    int status = pipe(fd);
    if (status == -1)
    {
        ShowError("pipe failed for gdb backtrace: %s", strerror(errno));
        _exit(EXIT_FAILURE);
    }
    pid_t child_pid = fork();

#ifdef HAS_YAMA_PRCTL
    // Tell yama that we allow our child_pid to trace our process
    if (child_pid > 0)
    {
        prctl(PR_SET_DUMPABLE, 1);
        prctl(PR_SET_PTRACER, child_pid);
    }
#endif

    if (child_pid < 0)
    {
        ShowError("Fork failed for gdb backtrace");
    }
    else if (child_pid == 0)
    {
        // NOTE: gdb-7.8 has regression, either update or downgrade.
        close(fd[0]);
        char buf[255];
        snprintf(buf, sizeof(buf), "gdb -p %d -n -batch -ex generate-core-file -ex bt 2>/dev/null 1>&%d", getppid(), fd[1]);
        execl("/bin/sh", "/bin/sh", "-c", buf, NULL);
        ShowError("Failed to launch gdb for backtrace");
        _exit(EXIT_FAILURE);
    }
    else
    {
        close(fd[1]);
        waitpid(child_pid, nullptr, 0);
        char buf[4096] = { 0 };
        status         = read(fd[0], buf, sizeof(buf) - 1);
        if (status == -1)
        {
            ShowError("read failed for gdb backtrace: %s", strerror(errno));
            _exit(EXIT_FAILURE);
        }
        ShowFatalError("--- gdb backtrace ---\n%s", buf);
    }
#endif
}

/************************************************************************
 *																		*
 *  CORE : Signal Sub Function											*
 *																		*
 ************************************************************************/

static void sig_proc(int sn)
{
    static int is_called = 0;

    switch (sn)
    {
        case SIGINT:
        case SIGTERM:
            if (++is_called > 3)
            {
                do_final(EXIT_SUCCESS);
            }
            runflag = 0;
            break;
        case SIGABRT:
        case SIGSEGV:
        case SIGFPE:
            dump_backtrace();
            do_abort();
            // Pass the signal to the system's default handler
            compat_signal(sn, SIG_DFL);
            raise(sn);
            break;
#ifndef _WIN32
        case SIGXFSZ:
            // ignore and allow it to set errno to EFBIG
            ShowWarning("Max file size reached!\n");
            // run_flag = 0;	// should we quit?
            break;
        case SIGPIPE:
            // ShowInfo ("Broken pipe found... closing socket\n");	// set to eof in socket.c
            break; // does nothing here
#endif
    }
}

/************************************************************************
 *																		*
 *																		*
 *																		*
 ************************************************************************/

void signals_init()
{
    compat_signal(SIGTERM, sig_proc);
    compat_signal(SIGINT, sig_proc);
#ifndef _DEBUG // need unhandled exceptions to debug on Windows
    compat_signal(SIGABRT, sig_proc);
    compat_signal(SIGSEGV, sig_proc);
    compat_signal(SIGFPE, sig_proc);
#endif
#ifndef _WIN32
    compat_signal(SIGILL, SIG_DFL);
    compat_signal(SIGXFSZ, sig_proc);
    compat_signal(SIGPIPE, sig_proc);
    compat_signal(SIGBUS, SIG_DFL);
    compat_signal(SIGTRAP, SIG_DFL);
#endif
}

/************************************************************************
 *																		*
 *  CORE : Display title													*
 *																		*
 ************************************************************************/

static void display_title()
{
    ShowInfo("Topaz\n");
}

/************************************************************************
 *																		*
 *  Warning if logged in as superuser (root)								*
 *																		*
 ************************************************************************/

void usercheck()
{
#ifndef _WIN32
    if ((getuid() == 0) && (getgid() == 0))
    {
        ShowWarning("You are running Topaz as the root superuser.\n");
        ShowWarning("It is unnecessary and unsafe to run with root privileges.\n");
        sleep(3);
    }
#endif
}

/************************************************************************
 *																		*
 *  CORE : MAINROUTINE													*
 *																		*
 ************************************************************************/
#ifndef DEFINE_OWN_MAIN
int main(int argc, char** argv)
{
    { // initialize program arguments
        char* p1 = SERVER_NAME = argv[0];
        char* p2               = p1;
        while ((p1 = strchr(p2, '/')) != nullptr || (p1 = strchr(p2, '\\')) != nullptr)
        {
            SERVER_NAME = ++p1;
            p2          = p1;
        }
        arg_c = argc;
        arg_v = argv;
    }

    log_init(argc, argv);
    set_server_type();
    display_title();
    usercheck();
    signals_init();
    timer_init();
    socket_init();

    do_init(argc, argv);
    fd_set rfd;
    { // Main runtime cycle
        duration next;

        while (runflag)
        {
            next = CTaskMgr::getInstance()->DoTimer(server_clock::now());
            do_sockets(&rfd, next);
        }
    }

    do_final(EXIT_SUCCESS);
    return 0;
}
#endif