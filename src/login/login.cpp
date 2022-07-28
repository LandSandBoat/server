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
#include <io.h>
#define isatty _isatty
#else
#include <unistd.h>
#endif

#include "lobby.h"
#include "login.h"
#include "login_auth.h"
#include "message_server.h"

std::thread messageThread;

std::unique_ptr<SqlConnection> sql; // lgtm [cpp/short-global-name]

uint8 ver_lock   = 0;
uint8 maint_mode = 0;

int32 do_init(int32 argc, char** argv)
{
    login_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_AUTH_IP").c_str(), settings::get<uint16>("network.LOGIN_AUTH_PORT"), connect_client_login);
    ShowInfo("The login-server-auth is ready (Server is listening on the port %u).", settings::get<uint16>("network.LOGIN_AUTH_PORT"));

    login_lobbydata_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_DATA_IP").c_str(), settings::get<uint16>("network.LOGIN_DATA_PORT"), connect_client_lobbydata);
    ShowInfo("The login-server-lobbydata is ready (Server is listening on the port %u).", settings::get<uint16>("network.LOGIN_DATA_PORT"));

    login_lobbyview_fd = makeListenBind_tcp(settings::get<std::string>("network.LOGIN_VIEW_IP").c_str(), settings::get<uint16>("network.LOGIN_VIEW_PORT"), connect_client_lobbyview);
    ShowInfo("The login-server-lobbyview is ready (Server is listening on the port %u).", settings::get<uint16>("network.LOGIN_VIEW_PORT"));

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

    messageThread = std::thread(message_server_init);

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
    // clang-format on

    ShowInfo("The login-server is ready to work!");
    ShowInfo("=======================================================================");

    return 0;
}

void do_final(int code)
{
    message_server_close();
    if (messageThread.joinable())
    {
        messageThread.join();
    }

    timer_final();
    socket_final();

    logging::ShutDown();

    exit(code);
}

void do_abort()
{
    do_final(EXIT_FAILURE);
}

void set_server_type()
{
    SERVER_TYPE = XI_SERVER_LOGIN;
    SOCKET_TYPE = socket_type::TCP;
}

int do_sockets(fd_set* rfd, duration next)
{
    struct timeval timeout;

    // can timeout until the next tick
    timeout.tv_sec  = std::chrono::duration_cast<std::chrono::seconds>(next).count();
    timeout.tv_usec = std::chrono::duration_cast<std::chrono::microseconds>(next - std::chrono::duration_cast<std::chrono::seconds>(next)).count();

    memcpy(rfd, &readfds, sizeof(*rfd));
    int ret = sSelect(fd_max, rfd, nullptr, nullptr, &timeout);

    if (ret == SOCKET_ERROR)
    {
        if (sErrno != S_EINTR)
        {
            ShowCritical("do_sockets: select() failed, error code %d!", sErrno);
            exit(EXIT_FAILURE);
        }
        return 0; // interrupted by a signal, just loop and try again
    }

    last_tick = time(nullptr);

#if defined(WIN32_FD_INTERNALS) && defined(WIN32)
    // on windows, enumerating all members of the fd_set is way faster if we access the internals
    for (int i = 0; i < (int)rfd->fd_count; ++i)
    {
        int fd = sock2fd(rfd->fd_array[i]);
#ifdef _DEBUG
        ShowDebug(fmt::format("select fd: {}", i).c_str());
#endif // _DEBUG
        if (sessions[fd])
        {
            sessions[fd]->func_recv(fd);

            if (fd != login_fd && fd != login_lobbydata_fd && fd != login_lobbyview_fd)
            {
                sessions[fd]->func_parse(fd);

                if (!sessions[fd])
                {
                    continue;
                }

                // RFIFOFLUSH(fd);
            }
        }
    }
#else
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

                    // RFIFOFLUSH(fd);
                }
                --ret;
            }
        }
    }
#endif // defined(WIN32_FD_INTERNALS) && defined(WIN32)

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
