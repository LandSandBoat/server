/*
===========================================================================

  Copyright (c) 2010-2016 Darkstar Dev Teams

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
#include "common/logging.h"
#include "common/mmo.h"
#include "common/socket.h"
#include "common/timer.h"
#include "common/utils.h"
#include "common/version.h"

#include <cstdio>
#include <cstdlib>
#include <functional>
#include <iostream>
#include <limits>
#include <sstream>
#include <string>
#include <thread>
#include <vector>

#ifdef WIN32
#include "../ext/wepoll/wepoll.h"
#include <io.h>
#define isatty _isatty
#else
#include <unistd.h>

// MacOS has no epoll
#ifdef __APPLE__
#include <sys/ioctl.h>
#else
#include <sys/epoll.h>
#include <sys/resource.h>
#endif

typedef int HANDLE;
#endif

#ifndef __APPLE__
struct epoll_event events[MAX_FD] = {};
HANDLE             epollHandle    = 0;

struct epoll_event loginEpollEvent           = { EPOLLIN };
struct epoll_event login_lobbydataEpollEvent = { EPOLLIN };
struct epoll_event login_lobbyviewEpollEvent = { EPOLLIN };
#endif

#include "lobby.h"
#include "login.h"
#include "login_auth.h"
#include "login_conf.h"

std::unique_ptr<SqlConnection> sql;

uint8 ver_lock   = 0;
uint8 maint_mode = 0;

bool requestExit = false;

int32 do_init(int32 argc, char** argv)
{
    login_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_AUTH_IP").c_str(), settings::get<uint16>("network.LOGIN_AUTH_PORT"), connect_client_login);
    ShowInfo(fmt::format("The login-server-auth is ready (Server is listening on the port {}).", settings::get<uint16>("network.LOGIN_AUTH_PORT")));

    login_lobbydata_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_DATA_IP").c_str(), settings::get<uint16>("network.LOGIN_DATA_PORT"), connect_client_lobbydata);
    ShowInfo(fmt::format("The login-server-lobbydata is ready (Server is listening on the port {}).", settings::get<uint16>("network.LOGIN_DATA_PORT")));

    login_lobbyview_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_VIEW_IP").c_str(), settings::get<uint16>("network.LOGIN_VIEW_PORT"), connect_client_lobbyview);
    ShowInfo(fmt::format("The login-server-lobbyview is ready (Server is listening on the port {}).", settings::get<uint16>("network.LOGIN_VIEW_PORT")));

#ifndef __APPLE__
    epollHandle = epoll_create1(0);

    loginEpollEvent.data.fd           = login_fd;
    login_lobbydataEpollEvent.data.fd = login_lobbydata_fd;
    login_lobbyviewEpollEvent.data.fd = login_lobbyview_fd;
#ifdef WIN32
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, sock_arr[login_fd], &loginEpollEvent);
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, sock_arr[login_lobbydata_fd], &login_lobbydataEpollEvent);
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, sock_arr[login_lobbyview_fd], &login_lobbyviewEpollEvent);
#else
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, login_fd, &loginEpollEvent);
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, login_lobbydata_fd, &login_lobbydataEpollEvent);
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, login_lobbyview_fd, &login_lobbyviewEpollEvent);

    struct rlimit limits;

    // Get old limits
    if (getrlimit(RLIMIT_NOFILE, &limits) == 0)
    {
        // Increase open file limit, which includes sockets, to MAX_FD. This only effects the current process and child processes
        limits.rlim_cur = MAX_FD;
        if (setrlimit(RLIMIT_NOFILE, &limits) == -1)
        {
            ShowError("Failed to increase rlim_cur to %d", MAX_FD);
        }
    }
#endif
#endif

    // NOTE: See login_conf.h for more information about what happens on this port
    // login_lobbyconf_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_CONF_IP").c_str(), settings::get<uint16>("network.LOGIN_CONF_PORT"), connect_client_lobbyconf);
    // ShowInfo("The login-server-lobbyconf is ready (Server is listening on the port %u).", settings::get<uint16>("network.LOGIN_CONF_PORT"));

    sql = std::make_unique<SqlConnection>();

    const char* fmtQuery = "OPTIMIZE TABLE `accounts`,`accounts_banned`, `accounts_sessions`, `chars`,`char_equip`, \
                           `char_inventory`, `char_jobs`,`char_look`,`char_stats`, `char_vars`, `char_bazaar_msg`, \
                           `char_skills`, `char_titles`, `char_effects`, `char_exp`;";

    if (sql->Query(fmtQuery) == SQL_ERROR)
    {
        ShowError("do_init: Impossible to optimise tables");
    }

    if (!settings::get<bool>("login.ACCOUNT_CREATION"))
    {
        ShowInfo("New account creation is currently disabled.");
    }

    if (!settings::get<bool>("login.CHARACTER_DELETION"))
    {
        ShowInfo("Character deletion is currently disabled.");
    }

    // clang-format off
    gConsoleService = std::make_unique<ConsoleService>();

    // TODO: Writing back to settings files
    gConsoleService->RegisterCommand(
    "verlock", "Cycle between version lock acceptance modes.",
    [&](std::vector<std::string> inputs)
    {
        // handle wrap around from 2 -> 3 as 0
        auto temp = (ver_lock + 1) % 3;
        ver_lock  = temp;

        const char* value = "";
        switch (ver_lock)
        {
            case 0:
                value = "disabled";
                break;
            case 1:
                value = "enabled - strict";
                break;
            case 2:
                value = "enabled - greater than or equal";
                break;
        }
        fmt::printf("Version lock mode: %i - %s\n", ver_lock, value);
    });

    gConsoleService->RegisterCommand(
    "maint_mode", "Cycle between maintenance modes.",
    [&](std::vector<std::string> inputs)
    {
        maint_mode = (maint_mode + 1) % 2;
        fmt::printf("Maintenance mode changed to %i\n", maint_mode);
    });

    gConsoleService->RegisterCommand(
    "show_fds", "Print current amount of File Descriptors in use.",
    [&](std::vector<std::string> inputs)
    {
        fmt::printf("Total fds in use: %i (4 are reserved for login itself)\n", fd_max);
    });

    gConsoleService->RegisterCommand("exit", "Terminate the program.",
    [&](std::vector<std::string> inputs)
    {
        fmt::print("> Goodbye!\n");
        // gConsoleService->stop(); // Kernel calls this, uncomment when decoupled from kernel
        gRunFlag = false;
        //do_final(EXIT_SUCCESS); // Kernel calls this, uncomment or replace when decoupled from kernel
    });
    // clang-format on

    ShowInfo("The login-server is ready to work!");
    ShowInfo("=======================================================================");

    return 0;
}

void do_final(int code)
{
    requestExit = true;

    timer_final();
    socket_final();

    sql = nullptr;
    logging::ShutDown();

    if (code != EXIT_SUCCESS)
    {
        exit(code);
    }
}

void do_abort()
{
    do_final(EXIT_FAILURE);
}

void set_socket_type()
{
    SOCKET_TYPE = socket_type::TCP;
}

int do_sockets(fd_set* rfd, duration next)
{
    int ret = 0;

#ifdef __APPLE__
    struct timeval timeout;
    // can timeout until the next tick
    timeout.tv_sec  = std::chrono::duration_cast<std::chrono::seconds>(next).count();
    timeout.tv_usec = std::chrono::duration_cast<std::chrono::microseconds>(next - std::chrono::duration_cast<std::chrono::seconds>(next)).count();

    memcpy(rfd, &readfds, sizeof(*rfd));
    ret = sSelect(fd_max, rfd, nullptr, nullptr, &timeout);

    if (ret == SOCKET_ERROR)
    {
        if (sErrno != S_EINTR)
        {
            ShowCritical(fmt::format("do_sockets: select() failed, error code {}!", sErrno));
            exit(EXIT_FAILURE);
        }
        return 0; // interrupted by a signal, just loop and try again
    }
#else
    ret = epoll_wait(epollHandle, events, fd_max, std::chrono::duration_cast<std::chrono::milliseconds>(next).count());
    if (ret == SOCKET_ERROR)
    {
        if (sErrno != S_EINTR)
        {
            ShowCritical("do_sockets: epoll_wait() failed, error code %d!", sErrno);
            exit(EXIT_FAILURE);
        }
        return 0; // interrupted by a signal, just loop and try again
    }
    else if (ret == 0)
    {
        return 0;
    }
#endif
    last_tick = time(nullptr);

#if __APPLE__
    // otherwise assume that the fd_set is a bit-array and enumerate it in a standard way
    for (int fd = 1; ret && fd < fd_max; ++fd)
    {
        if (sFD_ISSET(fd, rfd) && sessions[fd])
        {
            sessions[fd]->func_recv(fd);

            if (sessions[fd])
            {
                if (fd != login_fd && fd != login_lobbydata_fd && fd != login_lobbyview_fd)
                {
                    sessions[fd]->func_parse(fd);

                    if (!sessions[fd])
                    {
                        continue;
                    }
                }
                --ret;
            }
        }
    }
#else
    for (int i = 0; ret > 0 && i < fd_max; i++)
    {
        int  fd        = events[i].data.fd;
        auto thisEvent = events[i].events;

        // https://man7.org/linux/man-pages/man2/epoll_ctl.2.html
        // Handle all "always reported" error events
        // EPOLLHUP is an "unexpected" socket shutdown from client, but seems normal when disconnecting
        // EPOLLERR has not been witnessed, but is probably good to try to handle.
        if (thisEvent & EPOLLHUP || thisEvent & EPOLLERR)
        {
            do_close_tcp(fd);
            ret--;
            continue;
        }

        // Input recieved
        // EPOLLIN is normal input
        // EPOLLPRI appears to be "out of band" extra data from the socket. Needed to read data from sockets >1024(?)
        if (sessions[fd] && (thisEvent & EPOLLIN || thisEvent & EPOLLPRI))
        {
            ret--;

            // new session
            if (fd == login_fd || fd == login_lobbydata_fd || fd == login_lobbyview_fd)
            {
                struct epoll_event newEvent;
                newEvent.events  = EPOLLIN;
                newEvent.data.fd = sessions[fd]->func_recv(fd);
#ifdef WIN32
                epoll_ctl(epollHandle, EPOLL_CTL_ADD, sock_arr[newEvent.data.fd], &newEvent);
#else
                epoll_ctl(epollHandle, EPOLL_CTL_ADD, newEvent.data.fd, &newEvent);
#endif
            }
            else
            {
                sessions[fd]->func_recv(fd);
            }

            if (sessions[fd])
            {
                if (fd != login_fd && fd != login_lobbydata_fd && fd != login_lobbyview_fd)
                {
                    sessions[fd]->func_parse(fd);

                    if (!sessions[fd])
                    {
                        continue;
                    }
                }
            }
        }
    }
#endif
    for (int fd = 1; fd < fd_max; fd++)
    {
        if (!sessions[fd])
        {
            continue;
        }

        if (!sessions[fd]->wdata.empty())
        {
            sessions[fd]->func_send(fd);
        }
    }

    sql->TryPing();
    return 0;
}

void log_init(int argc, char** argv)
{
    std::string logFile;
    bool        appendDate{};

#ifdef WIN32
    logFile = "log\\login-server.log";
#else
    logFile = "log/login-server.log";
#endif
    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--log") == 0)
        {
            logFile = argv[i + 1];
        }
        else if (strcmp(argv[i], "--append-date") == 0)
        {
            appendDate = true;
        }
    }
    logging::InitializeLog("login", logFile, appendDate);
}
