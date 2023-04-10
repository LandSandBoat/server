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

#include "login_conf.h"

#include "common/logging.h"
#include "common/lua.h"
#include "common/md52.h"
#include "common/settings.h"
#include "common/socket.h"
#include "common/utils.h"

#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "lobby.h"
#include "login.h"

int32 login_lobbyconf_fd;

int32 connect_client_lobbyconf(int32 listenfd)
{
    int32              fd = 0;
    struct sockaddr_in client_address;
    if ((fd = connect_client(listenfd, client_address)) != -1)
    {
        create_session(fd, recv_to_fifo, send_from_fifo, lobbyconf_parse);
        sessions[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
        return fd;
    }
    return -1;
}

int32 lobbyconf_parse(int32 fd)
{
    // Convenience functions
    // clang-format off
    auto getRecvSize = [&](int32 fd) -> std::size_t
    {
        return RFIFOREST(fd);
    };

    // NOTE: This copies!
    auto getRecvData = [&](int32 fd) -> std::vector<uint8>
    {
        auto size = getRecvSize(fd);
        if (size == 0)
        {
            return {};
        }
        return std::vector<uint8>(&sessions[fd]->rdata[0], &sessions[fd]->rdata[0] + size);
    };

    // NOTE: This copies!
    auto sendData = [&](int32 fd, std::vector<uint8> data)
    {
        // TODO: This doesn't appear to need a hash?
        // unsigned char hash[16];
        // std::memset(data.data() + 12, 0, sizeof(hash));
        // md5(data.data(), hash, (int32)data.size());
        // std::memcpy(data.data() + 12, hash, sizeof(hash));

        sessions[fd]->wdata.assign((const char*)data.data(), data.size());

        RFIFOSKIP(fd, sessions[fd]->rdata.size());
        RFIFOFLUSH(fd);
    };

    auto dumpHex = [&](std::vector<uint8>& data)
    {
        auto index  = 0;
        auto outStr = std::string{};
        outStr += '\n';
        for (auto& byte : data)
        {
            outStr += fmt::format("{:02X} ", byte);
            if (index % 16 == 0 && index != 0)
            {
                outStr += '\n';
            }
            ++index;
        }
        outStr += '\n';
        ShowInfo(outStr);
    };
    // clang-format on

    auto data = getRecvData(fd);
    if (!data.empty())
    {
        auto data = getRecvData(fd);

        dumpHex(data);

        auto code = data.at(0);
        switch (code)
        {
            case 0x00:
            {
                // clang-format off
                sendData(fd,
                {
                    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                    0x00, 0x00, 0x00, 0x00, 0xF7, 0x11, 0x69, 0x63,
                });
                // clang-format on
                break;
            }
            case 0x02:
            {
                // clang-format off
                sendData(fd,
                {
                    0x86, 0x63, 0x09, 0x2F, 0x3D, 0x6B, 0x07, 0x1A, 0x93, 0x8E, 0xDB, 0x91, 0x6B, 0x20, 0x54, 0xFF,
                    0x3B, 0xF2, 0x39, 0xBB, 0x4A, 0x98, 0x9C, 0x7F,
                });
                // clang-format on
                break;
            }
            case 0x07:
                [[fallthrough]];
            case 0xDD:
            {
                // clang-format off
                sendData(fd,
                {
                    0x07, 0x67, 0x0C, 0x2F, 0x35, 0x6B, 0x07, 0x1A, 0x37, 0xB8, 0x98, 0x5B, 0x6B, 0x20, 0x54, 0xFF,
                    0x3B, 0xF2, 0x39, 0xBB, 0x4A, 0x98, 0x9C, 0x7F, 0xBC, 0xA4, 0x70, 0x47, 0x79, 0x11, 0x13, 0x70,
                    0x0C, 0x3B, 0xE2, 0x08, 0xA5, 0x63, 0xB7, 0xC5,
                });
                // clang-format on
                break;
            }
            default:
            {
                ShowError(fmt::format("Unknown login_conf packet code: {}", code));
                break;
            }
        }
    }

    return 0;
}

int32 do_close_lobbyconf(login_session_data_t* loginsd, int32 fd)
{
    if (loginsd != nullptr)
    {
        ShowInfo(fmt::format("do_close_lobbyconf: {} shutdown the socket", loginsd->login));
        if (session_isActive(loginsd->login_lobbyconf_fd))
        {
            do_close_tcp(loginsd->login_lobbyconf_fd);
        }
        erase_loginsd_byaccid(loginsd->accid);
        ShowInfo(fmt::format("lobbyconf_parse: {}'s login_session_data is deleted", loginsd->login));
        do_close_tcp(fd);
        return 0;
    }

    ShowInfo(fmt::format("lobbyconf_parse: {} shutdown the socket", ip2str(sessions[fd]->client_addr)));
    do_close_tcp(fd);
    return 0;
}
