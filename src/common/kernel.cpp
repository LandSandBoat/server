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
#include "../common/socket.h"
#include "../common/taskmgr.h"
#include "../common/timer.h"
#include "../common/version.h"

#include "debug.h"
#include "logging.h"

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

int runflag = 1;

char* SERVER_NAME = nullptr;
char  SERVER_TYPE = XI_SERVER_NONE;

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
        ShowWarning("You are running as the root superuser.");
        ShowWarning("It is unnecessary and unsafe to run with root privileges.");
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
    SERVER_NAME = argv[0];

    log_init(argc, argv);
    set_server_type();
    usercheck();
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