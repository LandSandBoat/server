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

int32 login_lobbydata_fd;
int32 login_lobbyview_fd;

int32 connect_client_lobbydata(int32 listenfd)
{
    int32              fd = 0;
    struct sockaddr_in client_address;
    if ((fd = connect_client(listenfd, client_address)) != -1)
    {
        create_session(fd, recv_to_fifo, send_from_fifo, lobbydata_parse);
        sessions[fd]->wdata.resize(5);
        sessions[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
        sessions[fd]->wdata[0]    = 0x01;
        return fd;
    }
    return -1;
}

int32 lobbydata_parse(int32 fd)
{
    login_session_data_t* sd = (login_session_data_t*)sessions[fd]->session_data;

    if (sd == nullptr)
    {
        if (RFIFOREST(fd) >= 5 && ref<uint8>(sessions[fd]->rdata.data(), 0) == 0xA1)
        {
            char* buff = &sessions[fd]->rdata[0];

            uint32 accid = ref<uint32>(buff, 1);

            sd = find_loginsd_byaccid(accid);
            if (sd == nullptr)
            {
                do_close_tcp(fd);
                return -1;
            }

            sd->login_lobbydata_fd     = fd;
            sessions[fd]->session_data = sd;
            return 0;
        }

        if (sd == nullptr)
        {
            do_close_tcp(fd);
            return -1;
        }
    }

    if (sessions[fd]->flag.eof)
    {
        do_close_lobbydata(sd, fd);
        return 0;
    }

    if (RFIFOREST(fd) >= 1)
    {
        char* buff = &sessions[fd]->rdata[0];
        if (ref<uint8>(buff, 0) == 0x0d)
        {
            ShowWarning(fmt::format("Possible Crash Attempt from IP: <{}>", ip2str(sessions[fd]->client_addr)));
        }
        ShowDebug(fmt::format("lobbydata_parse:Incoming Packet: <{}> from ip:<{}>", ref<uint8>(buff, 0), ip2str(sd->client_addr)));

        auto maintMode  = settings::get<uint8>("login.MAINT_MODE");
        auto searchPort = settings::get<uint16>("network.SEARCH_PORT");

        int32 code = ref<uint8>(buff, 0);
        switch (code)
        {
            case 0xA1:
            {
                if (RFIFOREST(fd) < 9)
                {
                    ShowError(fmt::format("lobbydata_parse: <{}> sent less then 9 bytes", ip2str(sessions[fd]->client_addr)));
                    do_close_lobbydata(sd, fd);
                    return -1;
                }
                char uList[500];
                std::memset(uList, 0, sizeof(uList));

                sd->servip = ref<uint32>(buff, 5);

                unsigned char CharList[2500];
                std::memset(CharList, 0, sizeof(CharList));
                // Store the reserved numbers.
                CharList[0] = 0xE0;
                CharList[1] = 0x08;
                CharList[4] = 0x49;
                CharList[5] = 0x58;
                CharList[6] = 0x46;
                CharList[7] = 0x46;
                CharList[8] = 0x20;

                const char* pfmtQuery = "SELECT content_ids FROM accounts WHERE id = %u;";
                int32       ret       = sql->Query(pfmtQuery, sd->accid);
                if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                {
                    CharList[28] = sql->GetUIntData(0);
                }
                else
                {
                    do_close_lobbydata(sd, fd);
                    return -1;
                }

                pfmtQuery = "SELECT charid, charname, pos_zone, pos_prevzone, mjob,\
                            race, face, head, body, hands, legs, feet, main, sub,\
                            war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng,\
                            sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run, \
                            gmlevel \
                        FROM chars \
                            INNER JOIN char_stats USING(charid)\
                            INNER JOIN char_look  USING(charid) \
                            INNER JOIN char_jobs  USING(charid) \
                            WHERE accid = %i \
                        LIMIT %u;";

                ret = sql->Query(pfmtQuery, sd->accid, CharList[28]);
                if (ret == SQL_ERROR)
                {
                    do_close_lobbydata(sd, fd);
                    return -1;
                }

                LOBBY_A1_RESERVEPACKET(ReservePacket);

                // server's name that shows in lobby menu
                auto serverName = settings::get<std::string>("main.SERVER_NAME");
                std::memcpy(ReservePacket + 60, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

                // Prepare the character list data..
                for (int j = 0; j < 16; ++j)
                {
                    std::memcpy(CharList + 32 + 140 * j, ReservePacket + 32, 140);
                    std::memset(CharList + 32 + 140 * j, 0x00, 4);
                    std::memset(uList + 16 * (j + 1), 0x00, 4);
                }

                uList[0] = 0x03;

                int i = 0;
                // Read information about a specific character.
                // Extract all the necessary information about the character from the database.
                while (sql->NextRow() != SQL_NO_DATA)
                {
                    char strCharName[16] = {}; // 15 characters + null terminator
                    std::memset(strCharName, 0, sizeof(strCharName));

                    std::string dbCharName = sql->GetStringData(1);
                    std::memcpy(strCharName, dbCharName.c_str(), dbCharName.length());

                    auto gmlevel = sql->GetIntData(36);
                    if (maintMode == 0 || gmlevel > 0)
                    {
                        uint8 worldId = 0; // Use when multiple worlds are supported.

                        uint32 charId    = sql->GetUIntData(0);
                        uint32 contentId = charId; // Reusing the character ID as the content ID (which is also the name of character folder within the USER directory) at the moment

                        // The character ID is made up of two parts totalling 24 bits:
                        uint16 charIdMain  = charId & 0xFFFF;
                        uint8  charIdExtra = (charId >> 16) & 0xFF;

                        // uList is sent through data socket (to bootloader)
                        uint32 uListOffset = 16 * (i + 1);

                        ref<uint32>(uList, uListOffset)     = contentId;
                        ref<uint16>(uList, uListOffset + 4) = charIdMain;
                        ref<uint8>(uList, uListOffset + 6)  = worldId;
                        ref<uint8>(uList, uListOffset + 7)  = charIdExtra;

                        // CharList is sent through view socket (to the FFXI client)
                        uint32 charListOffset = 32 + i * 140;

                        ref<uint32>(CharList, charListOffset)     = contentId;
                        ref<uint16>(CharList, charListOffset + 4) = charIdMain;
                        ref<uint8>(CharList, charListOffset + 6)  = worldId;
                        ref<uint8>(CharList, charListOffset + 11) = charIdExtra;

                        std::memcpy(CharList + charListOffset + 12, &strCharName, 16);

                        uint16 zone = (uint16)sql->GetUIntData(2);

                        uint8 MainJob    = (uint8)sql->GetUIntData(4);
                        uint8 lvlMainJob = (uint8)sql->GetUIntData(13 + MainJob);

                        ref<uint8>(CharList, charListOffset + 46) = MainJob;
                        ref<uint8>(CharList, charListOffset + 73) = lvlMainJob;

                        ref<uint8>(CharList, charListOffset + 44)  = (uint8)sql->GetUIntData(5);   // race
                        ref<uint8>(CharList, charListOffset + 56)  = (uint8)sql->GetUIntData(6);   // face
                        ref<uint16>(CharList, charListOffset + 58) = (uint16)sql->GetUIntData(7);  // head
                        ref<uint16>(CharList, charListOffset + 60) = (uint16)sql->GetUIntData(8);  // body
                        ref<uint16>(CharList, charListOffset + 62) = (uint16)sql->GetUIntData(9);  // hands
                        ref<uint16>(CharList, charListOffset + 64) = (uint16)sql->GetUIntData(10); // legs
                        ref<uint16>(CharList, charListOffset + 66) = (uint16)sql->GetUIntData(11); // feet
                        ref<uint16>(CharList, charListOffset + 68) = (uint16)sql->GetUIntData(12); // main
                        ref<uint16>(CharList, charListOffset + 70) = (uint16)sql->GetUIntData(13); // sub

                        ref<uint8>(CharList, charListOffset + 72)  = (uint8)zone;
                        ref<uint16>(CharList, charListOffset + 78) = zone;

                        ++i;
                    }
                }

                // the filtering above removes any non-GM characters so
                // at this point we need to make sure stop players with empty lists
                // from logging in or creating new characters
                if (maintMode > 0 && i == 0)
                {
                    LOBBBY_ERROR_MESSAGE(ReservePacketEmptyList);
                    ref<uint16>(ReservePacketEmptyList, 32) = 321;

                    unsigned char Hash[16];
                    uint8         SendBuffSize = ref<uint8>(ReservePacketEmptyList, 0);

                    std::memset(ReservePacketEmptyList + 12, 0, sizeof(Hash));
                    md5(ReservePacketEmptyList, Hash, SendBuffSize);

                    std::memcpy(ReservePacketEmptyList + 12, Hash, sizeof(Hash));
                    sessions[sd->login_lobbyview_fd]->wdata.assign((const char*)ReservePacketEmptyList, SendBuffSize);

                    RFIFOSKIP(sd->login_lobbyview_fd, sessions[sd->login_lobbyview_fd]->rdata.size());
                    RFIFOFLUSH(sd->login_lobbyview_fd);
                    ShowWarning(fmt::format("lobbydata_parse: char:({}) login during maintenance mode (0xA2). Sending error to client.", sd->accid));
                    // TODO: consider logging failed attempts during maintenance
                    return -1;
                }

                if (sessions[sd->login_lobbyview_fd] != nullptr)
                {
                    // write into lobbydata
                    uList[1] = 0x10;
                    sessions[fd]->wdata.assign(uList, 0x148);
                    RFIFOSKIP(fd, sessions[fd]->rdata.size());
                    RFIFOFLUSH(fd);
                    ////////////////////////////////////////

                    unsigned char hash[16];
                    md5((unsigned char*)(CharList), hash, 2272);

                    std::memcpy(CharList + 12, hash, 16);
                    // write into lobbyview
                    sessions[sd->login_lobbyview_fd]->wdata.assign((const char*)CharList, 2272);
                    RFIFOSKIP(sd->login_lobbyview_fd, sessions[sd->login_lobbyview_fd]->rdata.size());
                    RFIFOFLUSH(sd->login_lobbyview_fd);
                }
                else // Cleanup
                {
                    ShowWarning(fmt::format("lobbydata_parse: char:({}) login data corrupt (0xA1). Disconnecting client.", sd->accid));
                    do_close_lobbydata(sd, fd);
                    return -1;
                }
                /////////////////////////////////////////

                break;
            }
            case 0xA2:
            {
                LOBBY_A2_RESERVEPACKET(ReservePacket);
                uint8 key3[20];
                std::memset(key3, 0, sizeof(key3));
                std::memcpy(key3, buff + 1, sizeof(key3));
                key3[16] -= 2;
                uint8 MainReservePacket[0x48];

                RFIFOSKIP(fd, sessions[fd]->rdata.size());
                RFIFOFLUSH(fd);

                if (sessions[sd->login_lobbyview_fd] == nullptr)
                {
                    ShowWarning(fmt::format("lobbydata_parse: char:({}) login data corrupt (0xA2). Disconnecting client.", sd->accid));
                    do_close_lobbydata(sd, fd);
                    return -1;
                }

                auto   receivedData = sessions[sd->login_lobbyview_fd]->rdata.data();
                uint32 charid       = ref<uint32>(receivedData, 0x1C);

                const char* fmtQuery = "SELECT zoneip, zoneport, zoneid, pos_prevzone, gmlevel, accid, charname \
                                        FROM zone_settings, chars \
                                        WHERE IF(pos_zone = 0, zoneid = pos_prevzone, zoneid = pos_zone) AND charid = %u AND accid = %u;";

                uint32 ZoneIP   = sd->servip;
                uint16 ZonePort = 54230;
                uint16 ZoneID   = 0;
                uint16 PrevZone = 0;
                uint16 gmlevel  = 0;

                if (sql->Query(fmtQuery, charid, sd->accid) != SQL_ERROR && sql->NumRows() != 0)
                {
                    sql->NextRow();

                    ZoneID   = (uint16)sql->GetUIntData(2);
                    PrevZone = (uint16)sql->GetUIntData(3);
                    gmlevel  = (uint16)sql->GetUIntData(4);

                    // new char only (first login from char create)
                    if (sd->justCreatedNewChar)
                    {
                        key3[16] += 6;
                    }

                    inet_pton(AF_INET, (const char*)sql->GetData(0), &ZoneIP);
                    ZonePort                           = (uint16)sql->GetUIntData(1);
                    ref<uint32>(ReservePacket, (0x38)) = ZoneIP;
                    ref<uint16>(ReservePacket, (0x3C)) = ZonePort;

                    char strCharName[16] = {}; // 15 characters + null terminator
                    std::memset(strCharName, 0, sizeof(strCharName));

                    std::string dbCharName = sql->GetStringData(6);
                    std::memcpy(strCharName, dbCharName.c_str(), dbCharName.length());

                    ref<uint32>(ReservePacket, 28) = charid;
                    ref<uint32>(ReservePacket, 32) = charid;
                    std::memcpy(ReservePacket + 36, &strCharName, 16);

                    ShowInfo(fmt::format("lobbydata_parse: zoneid:({}), zoneip:({}), zoneport:({}) for char:({})",
                                         ZoneID, ip2str(ntohl(ZoneIP)), ZonePort, charid));

                    // Check the number of sessions
                    uint16 sessionCount = 0;

                    fmtQuery = "SELECT COUNT(client_addr) \
                                FROM accounts_sessions \
                                WHERE client_addr = %u;";

                    if (sql->Query(fmtQuery, sd->client_addr) != SQL_ERROR && sql->NumRows() != 0)
                    {
                        sql->NextRow();
                        sessionCount = (uint16)sql->GetIntData(0);
                    }

                    fmtQuery = "SELECT UNIX_TIMESTAMP(exception) \
                                FROM ip_exceptions \
                                WHERE accid = %u;";

                    uint64 exceptionTime = 0;

                    if (sql->Query(fmtQuery, sd->accid) != SQL_ERROR && sql->NumRows() != 0)
                    {
                        sql->NextRow();
                        exceptionTime = sql->GetUInt64Data(0);
                    }

                    uint64 timeStamp    = std::chrono::duration_cast<std::chrono::seconds>(server_clock::now().time_since_epoch()).count();
                    bool   isNotMaint   = !settings::get<bool>("login.MAINT_MODE");
                    auto   loginLimit   = settings::get<uint8>("login.LOGIN_LIMIT");
                    bool   excepted     = exceptionTime > timeStamp;
                    bool   loginLimitOK = loginLimit == 0 || sessionCount < loginLimit || excepted;
                    bool   isGM         = gmlevel > 0;

                    if (!loginLimitOK)
                    {
                        ShowWarning(fmt::format("{} already has {} active session(s), limit is {}", sd->login, sessionCount, loginLimit));
                    }

                    if ((isNotMaint && loginLimitOK) || isGM)
                    {
                        if (PrevZone == 0)
                        {
                            sql->Query("UPDATE chars SET pos_prevzone = %d WHERE charid = %u;", ZoneID, charid);
                        }

                        ref<uint32>(ReservePacket, (0x40)) = sd->servip; // search-server ip
                        ref<uint16>(ReservePacket, (0x44)) = searchPort; // search-server port

                        std::memcpy(MainReservePacket, ReservePacket, ref<uint8>(ReservePacket, 0));

                        // If the session was not processed by the game server, then it must be deleted.
                        sql->Query("DELETE FROM accounts_sessions WHERE accid = %u and client_port = 0", sd->accid);

                        char session_key[sizeof(key3) * 2 + 1];
                        bin2hex(session_key, key3, sizeof(key3));

                        fmtQuery = "INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr, version_mismatch) "
                                   "VALUES(%u,%u,x'%s',%u,%u,%u,%u)";

                        if (sql->Query(fmtQuery, sd->accid, charid, session_key, ZoneIP, ZonePort, sd->client_addr,
                                       (uint8)sessions[sd->login_lobbyview_fd]->ver_mismatch) == SQL_ERROR)
                        {
                            // Send error message to the client.
                            LOBBBY_ERROR_MESSAGE(ReservePacketError);
                            // Set the error code:
                            //     Unable to connect to world server. Specified operation failed
                            ref<uint16>(ReservePacketError, 32) = 305;
                            std::memcpy(MainReservePacket, ReservePacketError, ref<uint8>(ReservePacketError, 0));
                        }

                        fmtQuery = "UPDATE char_stats SET zoning = 2 WHERE charid = %u";
                        sql->Query(fmtQuery, charid);
                    }
                    else
                    {
                        LOBBBY_ERROR_MESSAGE(ReservePacketError);
                        ref<uint16>(ReservePacket, 32) = 321;
                        std::memcpy(MainReservePacket, ReservePacketError, ref<uint8>(ReservePacketError, 0));
                    }
                }
                else
                {
                    // either there is no character for this charid/accid, or there is no zone for this char's zone
                    LOBBBY_ERROR_MESSAGE(ReservePacketError);
                    // Set the error code:
                    //     Unable to connect to world server. Specified operation failed
                    ref<uint16>(ReservePacketError, 32) = 305;
                    std::memcpy(MainReservePacket, ReservePacketError, ref<uint8>(ReservePacketError, 0));
                }

                unsigned char Hash[16];
                uint8         SendBuffSize = ref<uint8>(MainReservePacket, 0);

                std::memset(MainReservePacket + 12, 0, sizeof(Hash));
                md5(MainReservePacket, Hash, SendBuffSize);

                std::memcpy(MainReservePacket + 12, Hash, sizeof(Hash));
                sessions[sd->login_lobbyview_fd]->wdata.assign((const char*)MainReservePacket, SendBuffSize);

                RFIFOSKIP(sd->login_lobbyview_fd, sessions[sd->login_lobbyview_fd]->rdata.size());
                RFIFOFLUSH(sd->login_lobbyview_fd);

                if (SendBuffSize == 0x24)
                {
                    // In the event of an error, exit without breaking the connection.
                    return -1;
                }

                if (settings::get<bool>("login.LOG_USER_IP"))
                {
                    // Log clients IP info when player spawns into map server

                    time_t rawtime;
                    tm     convertedTime;
                    time(&rawtime);
                    _localtime_s(&convertedTime, &rawtime);

                    char timeAndDate[128];
                    strftime(timeAndDate, sizeof(timeAndDate), "%Y:%m:%d %H:%M:%S", &convertedTime);

                    fmtQuery = "INSERT INTO account_ip_record(login_time,accid,charid,client_ip)\
                            VALUES ('%s', %u, %u, '%s');";

                    if (sql->Query(fmtQuery, timeAndDate, sd->accid, charid, ip2str(sd->client_addr)) == SQL_ERROR)
                    {
                        ShowError("lobbyview_parse: Could not write info to account_ip_record.");
                    }
                }

                do_close_tcp(sd->login_lobbyview_fd);

                ShowInfo(fmt::format("lobbydata_parse: client {} finished work with lobbyview", ip2str(sd->client_addr)));
                break;
            }
            default:

                break;
        }
    }
    return 0;
};

int32 do_close_lobbydata(login_session_data_t* loginsd, int32 fd)
{
    if (loginsd != nullptr)
    {
        ShowInfo(fmt::format("lobbydata_parse: {} shutdown the socket", loginsd->login));
        if (session_isActive(loginsd->login_lobbyview_fd))
        {
            do_close_tcp(loginsd->login_lobbyview_fd);
        }
        erase_loginsd_byaccid(loginsd->accid);
        ShowInfo(fmt::format("lobbydata_parse: {}'s login_session_data is deleted", loginsd->login));
        do_close_tcp(fd);
        return 0;
    }

    ShowInfo(fmt::format("lobbydata_parse: {} shutdown the socket", ip2str(sessions[fd]->client_addr)));
    do_close_tcp(fd);
    return 0;
}

int32 connect_client_lobbyview(int32 listenfd)
{
    int32              fd = 0;
    struct sockaddr_in client_address;
    if ((fd = connect_client(listenfd, client_address)) != -1)
    {
        create_session(fd, recv_to_fifo, send_from_fifo, lobbyview_parse);
        sessions[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
        return fd;
    }
    return -1;
}

int32 lobbyview_parse(int32 fd)
{
    login_session_data_t* sd = (login_session_data_t*)sessions[fd]->session_data;

    if (sd == nullptr)
    {
        sd = find_loginsd_byip(sessions[fd]->client_addr);
        if (sd == nullptr)
        {
            do_close_tcp(fd);
            return -1;
        }
        sessions[fd]->session_data = sd;
        sd->login_lobbyview_fd     = fd;
    }

    if (sessions[fd]->flag.eof)
    {
        do_close_lobbyview(sd, fd);
        return 0;
    }

    if (RFIFOREST(fd) >= 9)
    {
        auto maintMode = settings::get<uint8>("login.MAINT_MODE");

        char* buff = &sessions[fd]->rdata[0];
        ShowDebug(fmt::format("lobbyview_parse:Incoming Packet: <{}> from ip:<{}>", ref<uint8>(buff, 8), ip2str(sd->client_addr)));
        uint8 code = ref<uint8>(buff, 8);
        switch (code)
        {
            case 0x26:
            {
                int32         sendsize = 0x28;
                unsigned char MainReservePacket[0x28];

                std::string client_ver_data((buff + 0x74), 6); // Full length is 10 but we drop last 4
                client_ver_data = client_ver_data + "xx_x";    // And then we replace those last 4..

                std::string expected_version(settings::get<std::string>("login.CLIENT_VER"), 0, 6); // Same deal here!
                expected_version   = expected_version + "xx_x";
                bool ver_mismatch  = expected_version != client_ver_data;
                bool fatalMismatch = false;

                if (ver_mismatch)
                {
                    ShowError(fmt::format("lobbyview_parse: Incorrect client version: got {}, expected {}", client_ver_data.c_str(), expected_version.c_str()));

                    switch (settings::get<uint8>("login.VER_LOCK"))
                    {
                        // enabled
                        case 1:
                            if (expected_version < client_ver_data)
                            {
                                ShowError("lobbyview_parse: The server must be updated to support this client version");
                            }
                            else
                            {
                                ShowError("lobbyview_parse: The client must be updated to support this server version");
                            }
                            fatalMismatch = true;
                            break;
                        // enabled greater than or equal
                        case 2:
                            if (expected_version > client_ver_data)
                            {
                                ShowError("lobbyview_parse: The client must be updated to support this server version");
                                fatalMismatch = true;
                            }
                            break;
                        default:
                            // no-op - not enabled or unknown verlock type
                            break;
                    }
                }

                if (fatalMismatch)
                {
                    sendsize = 0x24;
                    LOBBBY_ERROR_MESSAGE(ReservePacket);

                    ref<uint16>(ReservePacket, 32) = 331;
                    std::memcpy(MainReservePacket, ReservePacket, sendsize);
                }
                else
                {
                    const char* pfmtQuery = "SELECT expansions,features FROM accounts WHERE id = %u;";
                    int32       ret       = sql->Query(pfmtQuery, sd->accid);
                    if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                    {
                        LOBBY_026_RESERVEPACKET(ReservePacket);
                        ref<uint16>(ReservePacket, 32) = sql->GetUIntData(0); // Expansion Bitmask
                        ref<uint16>(ReservePacket, 36) = sql->GetUIntData(1); // Feature Bitmask
                        std::memcpy(MainReservePacket, ReservePacket, sendsize);
                    }
                    else
                    {
                        do_close_lobbydata(sd, fd);
                        return -1;
                    }
                }

                // Hash the packet data and then write the value of the hash into the packet.
                unsigned char Hash[16];
                md5(MainReservePacket, Hash, sendsize);
                std::memcpy(MainReservePacket + 12, Hash, 16);
                // Finalize the packet.
                sessions[fd]->wdata.assign((const char*)MainReservePacket, sendsize);
                sessions[fd]->ver_mismatch = ver_mismatch;
                RFIFOSKIP(fd, sessions[fd]->rdata.size());
                RFIFOFLUSH(fd);
            }
            break;
            case 0x14:
            {
                if (!settings::get<bool>("login.CHARACTER_DELETION"))
                {
                    int32         sendsize = 0x28;
                    unsigned char MainReservePacket[0x28];
                    LOBBBY_ERROR_MESSAGE(ReservePacket);
                    ref<uint16>(ReservePacket, 32) = 332;

                    std::memset(MainReservePacket, 0, sizeof(MainReservePacket));
                    std::memcpy(MainReservePacket, ReservePacket, sizeof(ReservePacket));

                    sessions[fd]->wdata.assign((const char*)MainReservePacket, sendsize);
                    RFIFOSKIP(fd, sessions[fd]->rdata.size());
                    RFIFOFLUSH(fd);
                    return -1;
                }

                // delete char
                uint32 CharID = ref<uint32>(sessions[fd]->rdata.data(), 0x20);

                ShowInfo(fmt::format("lobbyview_parse: attempt to delete char:<{}> from ip:<{}>",
                                     CharID, ip2str(sd->client_addr)));

                uint8 sendsize = 0x20;

                LOBBY_ACTION_DONE(ReservePacket);
                unsigned char hash[16];

                md5(ReservePacket, hash, sendsize);
                std::memcpy(ReservePacket + 12, hash, 16);

                sessions[fd]->wdata.assign((const char*)ReservePacket, sendsize);
                RFIFOSKIP(fd, sessions[fd]->rdata.size());
                RFIFOFLUSH(fd);

                // Perform character deletion from the database. It is sufficient to remove the
                // value from the `chars` table. The mysql server will handle the rest.

                const char* pfmtQuery = "DELETE FROM chars WHERE charid = %i AND accid = %i";
                sql->Query(pfmtQuery, CharID, sd->accid);

                break;
            }
            case 0x1F:
            {
                if (sessions[sd->login_lobbydata_fd] == nullptr)
                {
                    ShowInfo(fmt::format("0x1F nullptr: fd {} lobbydata fd {} lobbyview fd {}. Closing session.", fd, sd->login_lobbydata_fd, sd->login_lobbyview_fd));
                    uint32 val = 1337;
                    if (sd->login_lobbydata_fd - 1 >= 0 && sessions[sd->login_lobbydata_fd - 1] != nullptr)
                    {
                        val = sessions[sd->login_lobbydata_fd - 1]->client_addr;
                    }
                    ShowInfo(fmt::format("Details: {} ip {} and lobbydata-1 fd ip is {}", sd->login, sd->client_addr, val));
                    do_close_tcp(fd);
                    return -1;
                }
                sessions[sd->login_lobbydata_fd]->wdata.resize(5);
                ref<uint8>(sessions[sd->login_lobbydata_fd]->wdata.data(), 0) = 0x01;
            }
            break;
            case 0x24:
            {
                LOBBY_024_RESERVEPACKET(ReservePacket);

                auto serverName = settings::get<std::string>("main.SERVER_NAME");
                std::memcpy(ReservePacket + 36, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

                unsigned char Hash[16];

                md5((unsigned char*)(ReservePacket), Hash, 64);

                std::memcpy(ReservePacket + 12, Hash, 16);
                uint8 SendBuffSize = 64;
                sessions[fd]->wdata.append((const char*)ReservePacket, SendBuffSize);
                RFIFOSKIP(fd, sessions[fd]->rdata.size());
                RFIFOFLUSH(fd);
            }
            break;
            case 0x07:
            {
                if (sessions[sd->login_lobbydata_fd] == nullptr)
                {
                    ShowInfo(fmt::format("0x07 nullptr: fd {} lobbydata fd {} lobbyview fd {}. Closing session.", fd, sd->login_lobbydata_fd, sd->login_lobbyview_fd));
                    uint32 val = 1337;
                    if (sd->login_lobbydata_fd - 1 >= 0 && sessions[sd->login_lobbydata_fd - 1] != nullptr)
                    {
                        val = sessions[sd->login_lobbydata_fd - 1]->client_addr;
                    }
                    ShowInfo(fmt::format("Details: {} ip {} and lobbydata-1 fd ip is {}", sd->login, sd->client_addr, val));
                    do_close_tcp(fd);
                    return -1;
                }

                sessions[sd->login_lobbydata_fd]->wdata.resize(5);
                ref<uint8>(sessions[sd->login_lobbydata_fd]->wdata.data(), 0) = 0x02;
            }
            break;
            case 0x21:
            {
                // creating new char
                if (lobby_createchar(sd, (int8*)sessions[fd]->rdata.data()) == -1)
                {
                    do_close_lobbyview(sd, fd);
                    return -1;
                }

                sd->justCreatedNewChar = true;
                ShowInfo(fmt::format("lobbyview_parse: char <{}> was successfully created", sd->charname));
                /////////////////////////
                LOBBY_ACTION_DONE(ReservePacket);
                unsigned char hash[16];

                int32 sendsize = 32;
                md5((unsigned char*)(ReservePacket), hash, sendsize);

                std::memcpy(ReservePacket + 12, hash, sizeof(hash));
                sessions[fd]->wdata.assign((const char*)ReservePacket, sendsize);
                RFIFOSKIP(fd, sessions[fd]->rdata.size());
                RFIFOFLUSH(fd);
            }
            break;
            case 0x22:
            {
                int32         sendsize = 0x24;
                unsigned char MainReservePacket[0x24];

                // block creation of character if in maintenance mode
                if (maintMode > 0)
                {
                    LOBBBY_ERROR_MESSAGE(ReservePacket);
                    ref<uint16>(ReservePacket, 32) = 314;
                    std::memcpy(MainReservePacket, ReservePacket, sendsize);
                }
                else
                {
                    // creating new char
                    char CharName[16];
                    std::memset(CharName, 0, sizeof(CharName));
                    std::memcpy(CharName, sessions[fd]->rdata.data() + 32, sizeof(CharName));

                    // Sanitize name
                    char escapedCharName[16 * 2 + 1];
                    sql->EscapeString(escapedCharName, CharName);

                    std::optional<std::string> invalidNameReason = std::nullopt;

                    // Check for invalid characters
                    std::string nameStr(&escapedCharName[0]);
                    for (auto letters : nameStr)
                    {
                        if (!std::isalpha(letters))
                        {
                            invalidNameReason = "Invalid characters present in name.";
                            break;
                        }
                    }

                    // Check for invalid length name
                    // NOTE: The client checks for this. This is to guard
                    // against packet injection
                    if (nameStr.size() < 3 || nameStr.size() > 15)
                    {
                        invalidNameReason = "Invalid name length.";
                    }

                    // Check if the name is already in use by another character
                    if (sql->Query("SELECT charname FROM chars WHERE charname LIKE '%s'", escapedCharName) == SQL_ERROR)
                    {
                        invalidNameReason = "Internal entity name query failed.";
                    }
                    else if (sql->NumRows() != 0)
                    {
                        invalidNameReason = "Name already in use.";
                    }

                    // (optional) Check if the name is in use by NPC or Mob entities
                    if (settings::get<bool>("login.DISABLE_MOB_NPC_CHAR_NAMES"))
                    {
                        auto query =
                            "WITH results AS "
                            "( "
                            "    SELECT polutils_name AS `name` FROM npc_list "
                            "    UNION "
                            "    SELECT packet_name AS `name` FROM mob_pools "
                            ") "
                            "SELECT * FROM results WHERE REPLACE(REPLACE(UPPER(`name`), '-', ''), '_', '') LIKE REPLACE(REPLACE(UPPER('%s'), '-', ''), '_', '');";

                        if (sql->Query(query, nameStr) == SQL_ERROR)
                        {
                            invalidNameReason = "Internal entity name query failed";
                        }
                        else if (sql->NumRows() != 0)
                        {
                            invalidNameReason = "Name already in use.";
                        }
                    }

                    // (optional) Check if the name contains any words on the bad word list
                    auto loginSettingsTable = lua["xi"]["settings"]["login"].get<sol::table>();
                    if (auto badWordsList = loginSettingsTable.get_or<sol::table>("BANNED_WORDS_LIST", sol::lua_nil); badWordsList.valid())
                    {
                        auto potentialName = to_upper(nameStr);
                        for (auto entry : badWordsList)
                        {
                            auto badWord = to_upper(entry.second.as<std::string>());
                            if (potentialName.find(badWord) != std::string::npos)
                            {
                                invalidNameReason = fmt::format("Name matched with bad words list <{}>.", badWord);
                            }
                        }
                    }

                    if (invalidNameReason.has_value())
                    {
                        ShowWarning(fmt::format("lobbyview_parse: new character name error <{}>: {}", CharName, (*invalidNameReason).c_str()));

                        // Send error code:
                        // The character name you entered is unavailable. Please choose another name.
                        // TODO: This message is displayed in Japanese, needs fixing.
                        LOBBBY_ERROR_MESSAGE(ReservePacket);
                        ref<uint16>(ReservePacket, 32) = 313;
                        std::memcpy(MainReservePacket, ReservePacket, sendsize);
                    }
                    else
                    {
                        // copy charname
                        std::memcpy(sd->charname, CharName, 16);
                        sendsize = 0x20;
                        LOBBY_ACTION_DONE(ReservePacket);
                        std::memcpy(MainReservePacket, ReservePacket, sendsize);
                    }
                }

                unsigned char hash[16];

                md5(MainReservePacket, hash, sendsize);
                std::memcpy(MainReservePacket + 12, hash, 16);
                sessions[fd]->wdata.assign((const char*)MainReservePacket, sendsize);
                RFIFOSKIP(fd, sessions[fd]->rdata.size());
                RFIFOFLUSH(fd);
            }
            break;
            default:
                break;
        }
    }
    return 0;
};

int32 do_close_lobbyview(login_session_data_t* sd, int32 fd)
{
    ShowInfo(fmt::format("lobbyview_parse: {} shutdown the socket", sd->login));
    do_close_tcp(fd);
    return 0;
}

int32 lobby_createchar(login_session_data_t* loginsd, int8* buf)
{
    // Seed the random number generator.
    srand(clock());
    char_mini createchar;

    std::memcpy(createchar.m_name, loginsd->charname, 16);

    createchar.m_look.race = ref<uint8>(buf, 48);
    createchar.m_look.size = ref<uint8>(buf, 57);
    createchar.m_look.face = ref<uint8>(buf, 60);

    // Validate that the job is a starting job.
    uint8 mjob        = ref<uint8>(buf, 50);
    createchar.m_mjob = std::clamp<uint8>(mjob, 1, 6);

    // Log that the character attempting to create a non-starting job.
    if (mjob != createchar.m_mjob)
    {
        ShowInfo(fmt::format("lobby_createchar: {} attempted to create invalid starting job {} substituting {}",
                             loginsd->charname, mjob, createchar.m_mjob));
    }

    createchar.m_nation = ref<uint8>(buf, 54);

    switch (createchar.m_nation)
    {
        case 0x02: // windy start
            // do not allow windy walls as startzone.
            do
            {
                createchar.m_zone = (0xEE) + rand() % 4;
            } while (createchar.m_zone == 0xEF);
            break;
        case 0x01: // bastok start
            createchar.m_zone = 0xEA + rand() % 3;
            break;
        case 0x00: // sandy start
            createchar.m_zone = 0xE6 + rand() % 3;
            break;
    }

    const char* fmtQuery = "SELECT max(charid) FROM chars";

    if (sql->Query(fmtQuery) == SQL_ERROR)
    {
        return -1;
    }

    uint32 CharID = 0;

    if (sql->NumRows() != 0)
    {
        sql->NextRow();

        CharID = sql->GetUIntData(0) + 1;
    }

    if (lobby_createchar_save(loginsd->accid, CharID, &createchar) == -1)
    {
        return -1;
    }

    ShowDebug(fmt::format("lobby_createchar: char<{}> successfully saved", createchar.m_name));
    return 0;
};

int32 lobby_createchar_save(uint32 accid, uint32 charid, char_mini* createchar)
{
    const char* Query = "INSERT INTO chars(charid,accid,charname,pos_zone,nation) VALUES(%u,%u,'%s',%u,%u);";

    if (sql->Query(Query, charid, accid, createchar->m_name, createchar->m_zone, createchar->m_nation) == SQL_ERROR)
    {
        ShowDebug(fmt::format("lobby_ccsave: char<{}>, accid: {}, charid: {}", createchar->m_name, accid, charid));
        return -1;
    }

    Query = "INSERT INTO char_look(charid,face,race,size) VALUES(%u,%u,%u,%u);";

    if (sql->Query(Query, charid, createchar->m_look.face, createchar->m_look.race, createchar->m_look.size) == SQL_ERROR)
    {
        ShowDebug(fmt::format("lobby_cLook: char<{}>, charid: {}", createchar->m_name, charid));
        return -1;
    }

    Query = "INSERT INTO char_stats(charid,mjob) VALUES(%u,%u);";

    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        ShowDebug(fmt::format("lobby_cStats: charid: {}", charid));
        return -1;
    }

    // people reported char creation errors, here is a fix.

    Query = "INSERT INTO char_exp(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_jobs(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_points(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_unlocks(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_profile(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_storage(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    // hot fix
    Query = "DELETE FROM char_inventory WHERE charid = %u";
    if (sql->Query(Query, charid) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_inventory(charid) VALUES(%u);";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    if (settings::get<bool>("main.NEW_CHARACTER_CUTSCENE"))
    {
        Query = "INSERT INTO char_vars(charid, varname, value) VALUES(%u, '%s', %u);";
        if (sql->Query(Query, charid, "HQuest[newCharacterCS]notSeen", 1) == SQL_ERROR)
        {
            return -1;
        }
    }
    return 0;
}
