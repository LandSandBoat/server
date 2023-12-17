/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "data_session.h"

#include <common/utils.h>

void data_session::read_func()
{
    std::string sessionHash = loginHelpers::getHashFromPacket(ipAddress, data_);

    if (sessionHash == "")
    {
        // Attempt to use stored session hash.
        sessionHash = this->sessionHash;
        if (sessionHash == "")
        {
            ShowWarning(fmt::format("Session requested without valid sessionHash from {}", ipAddress));
            return;
        }
    }

    session_t& session = loginHelpers::get_authenticated_session(ipAddress, sessionHash);
    if (!session.data_session)
    {
        session.data_session              = std::make_shared<data_session>(std::forward<asio::ssl::stream<asio::ip::tcp::socket>>(socket_));
        session.data_session->sessionHash = sessionHash;
    }

    uint8 code = ref<uint8>(data_, 0);
    DebugSockets(fmt::format("data code: {} from {}", code, ipAddress));

    switch (code)
    {
        case 0xA1: // 161
        {
            auto   maintMode          = settings::get<uint8>("login.MAINT_MODE");
            uint32 recievedAcccountID = ref<uint32>(data_, 1);

            if (session.accountID == recievedAcccountID)
            {
                session.serverIP = ref<uint32>(data_, 5);

                auto   _sql          = std::make_unique<SqlConnection>();
                uint32 numContentIds = 0;
                int32  ret           = _sql->Query("SELECT content_ids FROM accounts WHERE id = %u;", session.accountID);

                numContentIds = _sql->NumRows();

                if (ret != SQL_ERROR && numContentIds != 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    numContentIds = _sql->GetUIntData(0);
                }
                else
                {
                    ShowWarning(fmt::format("Claimed accountID {} somehow doesn't have an account and should not have gotten this far.", session.accountID));

                    // Close socket so client errors.
                    socket_.lowest_layer().close();
                    return;
                }

                const char* pfmtQuery =
                    "SELECT charid, charname, pos_zone, pos_prevzone, mjob,\
                        race, face, head, body, hands, legs, feet, main, sub,\
                        war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng,\
                        sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run, \
                        gmlevel, nation, size, sjob \
                    FROM chars \
                        INNER JOIN char_stats USING(charid) \
                        INNER JOIN char_look  USING(charid) \
                        INNER JOIN char_jobs  USING(charid) \
                        WHERE accid = %i \
                    LIMIT %u;";

                ret = _sql->Query(pfmtQuery, session.accountID, numContentIds);
                if (ret == SQL_ERROR)
                {
                    socket_.lowest_layer().close();
                    return;
                }

                lpkt_chr_info2 characterInfoResponse = {};
                characterInfoResponse.terminator     = loginPackets::getTerminator();
                characterInfoResponse.command        = 0x20;
                loginPackets::clearIdentifier(characterInfoResponse);
                // server's name that shows in lobby menu
                auto serverName = settings::get<std::string>("main.SERVER_NAME");

                char uList[500] = {};

                int i = 0;

                // Extract all the necessary information about each character from the database and load up the struct.
                while (_sql->NextRow() != SQL_NO_DATA)
                {
                    char strCharName[16] = {}; // 15 characters + null terminator
                    std::memset(strCharName, 0, sizeof(strCharName));

                    std::string dbCharName = _sql->GetStringData(1);
                    std::memcpy(strCharName, dbCharName.c_str(), dbCharName.length());

                    int32 gmlevel = _sql->GetIntData(36);
                    if (maintMode == 0 || gmlevel > 0)
                    {
                        uint8 worldId = 0; // Use when multiple worlds are supported.

                        uint32 charId    = _sql->GetUIntData(0);
                        uint32 contentId = charId; // Reusing the character ID as the content ID (which is also the name of character folder within the USER directory) at the moment

                        // The character ID is made up of two parts totalling 24 bits:
                        uint16 charIdMain  = charId & 0xFFFF;
                        uint8  charIdExtra = (charId >> 16) & 0xFF;

                        auto& characterInfo = characterInfoResponse.character_info[i];

                        characterInfo.ffxi_id           = contentId;
                        characterInfo.ffxi_id_world     = charIdMain;
                        characterInfo.worldid           = worldId;
                        characterInfo.status            = 1; // 0 = Invalid/Hidden, 1 = Available, 2 = Disabled (unpaid)
                        characterInfo.renamef           = 0; // 0 = no rename required, 1 = rename required (NOT YET SUPPORTED!)
                        characterInfo.ffxi_id_world_tbl = charIdExtra;

                        std::memcpy(characterInfo.character_name, &strCharName, 16);
                        std::memcpy(characterInfo.world_name, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

                        uint16 zone = static_cast<uint16>(_sql->GetUIntData(2));

                        uint8 MainJob    = static_cast<uint8>(_sql->GetUIntData(4));
                        uint8 lvlMainJob = static_cast<uint8>(_sql->GetUIntData(13 + MainJob));

                        characterInfo.character_info.mon_no     = static_cast<uint16>(_sql->GetUIntData(5)); // race
                        characterInfo.character_info.mjob_no    = MainJob;
                        characterInfo.character_info.mjob_level = lvlMainJob;
                        characterInfo.character_info.sjob_no    = static_cast<uint16>(_sql->GetUIntData(39));
                        characterInfo.character_info.face_no    = static_cast<uint16>(_sql->GetUIntData(6)); // face, may not be calculated correctly?
                        characterInfo.character_info.town_no    = static_cast<uint8>(_sql->GetUIntData(37)); // nation
                        characterInfo.character_info.zone_no    = static_cast<uint8>(zone);
                        characterInfo.character_info.zone_no2   = static_cast<uint8>((zone >> 8) & 1);
                        characterInfo.character_info.hair_no    = static_cast<uint8>(_sql->GetUIntData(6)); // face, may not be calculated correctly?
                        characterInfo.character_info.size       = static_cast<uint8>(_sql->GetUIntData(38));

                        characterInfo.character_info.GrapIDTbl[0] = static_cast<uint16>(_sql->GetUIntData(6));  // face, may not be calculated correctly?
                        characterInfo.character_info.GrapIDTbl[1] = static_cast<uint16>(_sql->GetUIntData(7));  // head
                        characterInfo.character_info.GrapIDTbl[2] = static_cast<uint16>(_sql->GetUIntData(8));  // body
                        characterInfo.character_info.GrapIDTbl[3] = static_cast<uint16>(_sql->GetUIntData(9));  // hands
                        characterInfo.character_info.GrapIDTbl[4] = static_cast<uint16>(_sql->GetUIntData(10)); // legs
                        characterInfo.character_info.GrapIDTbl[5] = static_cast<uint16>(_sql->GetUIntData(11)); // feet
                        characterInfo.character_info.GrapIDTbl[6] = static_cast<uint16>(_sql->GetUIntData(12)); // main
                        characterInfo.character_info.GrapIDTbl[7] = static_cast<uint16>(_sql->GetUIntData(13)); // sub

                        // uList is sent through data socket (to xiloader)
                        uint32 uListOffset = 16 * (i + 1);

                        ref<uint32>(uList, uListOffset)     = contentId;
                        ref<uint16>(uList, uListOffset + 4) = charIdMain;
                        ref<uint8>(uList, uListOffset + 6)  = worldId;     // Ignored in xiloader?
                        ref<uint8>(uList, uListOffset + 7)  = charIdExtra; // Ignored in xiloader?

                        ++i;
                        characterInfoResponse.characters++;
                    }
                }

                auto allowCharacterCreation = settings::get<uint8>("login.CHARACTER_CREATION");
                if (allowCharacterCreation)
                {
                    // make extra char slots available if no characters are occupying the slots and their max content IDs supports it
                    while (characterInfoResponse.characters < numContentIds)
                    {
                        characterInfoResponse.character_info[characterInfoResponse.characters].status            = 0x01; // Available
                        characterInfoResponse.character_info[characterInfoResponse.characters].character_name[0] = 0x20; // space to display empty character slot, NULL displays a hume in a slot.
                        characterInfoResponse.characters++;
                    }
                }

                // the filtering above removes any non-GM characters so
                // at this point we need to make sure stop players with empty lists
                // from logging in or creating new characters
                if (maintMode > 0 && i == 0)
                {
                    if (auto data = session.view_session.get())
                    {
                        loginHelpers::generateErrorMessage(data->data_, loginErrors::errorCode::COULD_NOT_CONNECT_TO_LOBBY_SERVER);
                        data->do_write(0x24);
                    }
                    ShowWarning(fmt::format("char:({}) attmpted login during maintenance mode (0xA2). Sending error to client.", session.accountID));
                    return;
                }

                if (auto data = session.data_session.get())
                {
                    uList[0] = 0x03;                             // Send character list command in xiloader
                    uList[1] = characterInfoResponse.characters; // xiloader interprets this as the number of characters in the list

                    std::memset(data->data_, 0, sizeof(data_));
                    std::memcpy(data->data_, uList, 0x148);

                    data->do_write(0x148);
                }

                if (auto data = session.view_session.get())
                {
                    // size of packet + 1 uint32 + the actually set number of characters
                    uint32_t size                     = sizeof(packet_t) + sizeof(uint32_t) + sizeof(lpkt_chr_info_sub2) * characterInfoResponse.characters;
                    characterInfoResponse.packet_size = size;

                    unsigned char hash[16] = {};
                    md5(reinterpret_cast<uint8*>(&characterInfoResponse), hash, size);

                    loginPackets::copyHashIntoPacket(characterInfoResponse, hash);

                    std::memset(data->data_, 0, sizeof(data_));
                    std::memcpy(data->data_, &characterInfoResponse, size);
                    data->do_write(size);
                }
            }
        }
        break;
        case 0xA2: // 162 : "Notifying lobby of current selections" pt 2
        {
            // Some kind of magic regarding the blowfish keys
            uint8 key3[20] = {};
            std::memcpy(key3, data_ + 1, sizeof(key3));
            key3[16] -= 2;

            // https://github.com/atom0s/XiPackets/blob/main/lobby/S2C_0x000B_ResponseNextLogin.md
            lpkt_next_login characterSelectionResponse = {};

            characterSelectionResponse.packet_size = 0x48; // size
            characterSelectionResponse.terminator  = loginPackets::getTerminator();
            characterSelectionResponse.command     = 0x0B;
            loginPackets::clearIdentifier(characterSelectionResponse);

            if (session.accountID == 0)
            {
                ShowWarning(fmt::format("data_session: login data corrupt (0xA2). Disconnecting client {}", ipAddress));

                loginHelpers::generateErrorMessage(data_, loginErrors::errorCode::COULD_NOT_CONNECT_TO_LOBBY_SERVER);
                do_write(0x24);
                socket_.lowest_layer().close();
                return;
            }

            uint32 charid    = session.requestedCharacterID;
            uint32 accountIP = loginHelpers::str2ip(ipAddress.c_str());

            uint32 ZoneIP   = 0;
            uint16 ZonePort = 0;
            uint16 ZoneID   = 0;
            uint16 PrevZone = 0;
            uint16 gmlevel  = 0;

            auto _sql = std::make_unique<SqlConnection>();

            if (_sql->Query("SELECT zoneip, zoneport, zoneid, pos_prevzone, gmlevel, accid, charname \
                                             FROM zone_settings, chars \
                                             WHERE IF(pos_zone = 0, zoneid = pos_prevzone, zoneid = pos_zone) AND charid = %u AND accid = %u;",
                            charid, session.accountID) != SQL_ERROR &&
                _sql->NumRows() != 0)
            {
                _sql->NextRow();

                ZoneID   = static_cast<uint16>(_sql->GetUIntData(2));
                PrevZone = static_cast<uint16>(_sql->GetUIntData(3));
                gmlevel  = static_cast<uint16>(_sql->GetUIntData(4));

                // new char only (first login from char create)
                if (session.justCreatedNewChar)
                {
                    key3[16] += 6;
                }

                inet_pton(AF_INET, (const char*)_sql->GetData(0), &ZoneIP);
                ZonePort = (uint16)_sql->GetUIntData(1);

                characterSelectionResponse.server_ip   = ZoneIP;
                characterSelectionResponse.server_port = ZonePort;

                char strCharName[PacketNameLength] = {}; // 15 characters + null terminator
                std::memset(strCharName, 0, sizeof(strCharName));

                std::string dbCharName = _sql->GetStringData(6);
                std::memcpy(strCharName, dbCharName.c_str(), std::clamp<size_t>(dbCharName.length(), 3, PacketNameLength - 1));
                std::memcpy(characterSelectionResponse.character_name, &strCharName, 16);

                characterSelectionResponse.ffxi_id       = charid;
                characterSelectionResponse.ffxi_id_world = charid & 0xFFFF;
                characterSelectionResponse.server_id     = (charid >> 16) & 0xFF; // Looks wrong? shouldn't this be a server index?

                ShowInfo(fmt::format("data_session: zoneid:({}), zoneip:({}), zoneport:({}) for char:({})",
                                     ZoneID, loginHelpers::ip2str(ntohl(ZoneIP)), ZonePort, charid));

                // Check the number of sessions
                uint16 sessionCount = 0;

                if (_sql->Query("SELECT COUNT(client_addr) \
                                FROM accounts_sessions \
                                WHERE client_addr = %u;",
                                accountIP) != SQL_ERROR &&
                    _sql->NumRows() != 0)
                {
                    _sql->NextRow();
                    sessionCount = (uint16)_sql->GetIntData(0);
                }

                bool hasActiveSession = false;

                if (_sql->Query("SELECT * \
                                FROM accounts_sessions \
                                WHERE accid = %u and client_port != '0';",
                                session.accountID) != SQL_ERROR &&
                    _sql->NumRows() != 0)
                {
                    _sql->NextRow();
                    hasActiveSession = true;
                }

                uint64 exceptionTime = 0;

                if (_sql->Query("SELECT UNIX_TIMESTAMP(exception) \
                                FROM ip_exceptions \
                                WHERE accid = %u;",
                                session.accountID) != SQL_ERROR &&
                    _sql->NumRows() != 0)
                {
                    _sql->NextRow();
                    exceptionTime = _sql->GetUInt64Data(0);
                }

                uint64 timeStamp    = std::chrono::duration_cast<std::chrono::seconds>(server_clock::now().time_since_epoch()).count();
                bool   isNotMaint   = !settings::get<bool>("login.MAINT_MODE");
                auto   loginLimit   = settings::get<uint8>("login.LOGIN_LIMIT");
                bool   excepted     = exceptionTime > timeStamp;
                bool   loginLimitOK = loginLimit == 0 || sessionCount < loginLimit || excepted;
                bool   isGM         = gmlevel > 0;

                if (!loginLimitOK)
                {
                    ShowWarning(fmt::format("data_session: account {} attempting to login when {} already has {} active session(s), limit is {}", session.accountID, ipAddress, sessionCount, loginLimit));
                }

                if (hasActiveSession)
                {
                    ShowWarning(fmt::format("data_session: account {} is already logged in.", session.accountID));
                    if (auto data = session.view_session.get())
                    {
                        // Send error message to the client.
                        loginHelpers::generateErrorMessage(data->data_, loginErrors::errorCode::UNABLE_TO_CONNECT_TO_WORLD_SERVER); // "Unable to connect to world server. Specified operation failed"
                        data->do_write(0x24);
                        return;
                    }
                }

                if ((isNotMaint && loginLimitOK) || isGM)
                {
                    if (PrevZone == 0)
                    {
                        _sql->Query("UPDATE chars SET pos_prevzone = %d WHERE charid = %u;", ZoneID, charid);
                    }
                    auto searchPort                       = settings::get<uint16>("network.SEARCH_PORT");
                    characterSelectionResponse.cache_ip   = session.serverIP; // search-server ip
                    characterSelectionResponse.cache_port = searchPort;

                    // If the session was not processed by the game server, then it must be deleted.
                    _sql->Query("DELETE FROM accounts_sessions WHERE accid = %u and client_port = 0", session.accountID);

                    char session_key[sizeof(key3) * 2 + 1];
                    bin2hex(session_key, key3, sizeof(key3));

                    if (_sql->Query("INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr, version_mismatch) "
                                    "VALUES(%u,%u,x'%s',%u,%u,%u,%u)",
                                    session.accountID, charid, session_key, ZoneIP, ZonePort, accountIP,
                                    session.versionMismatch ? 1 : 0) == SQL_ERROR)
                    {
                        if (auto data = session.view_session.get())
                        {
                            // Send error message to the client.
                            loginHelpers::generateErrorMessage(data->data_, loginErrors::errorCode::UNABLE_TO_CONNECT_TO_WORLD_SERVER); // "Unable to connect to world server. Specified operation failed"
                            data->do_write(0x24);
                            return;
                        }
                    }

                    _sql->Query("UPDATE char_stats SET zoning = 2 WHERE charid = %u", charid);
                }
                else
                {
                    if (auto data = session.view_session.get())
                    {
                        // Send error message to the client.
                        loginHelpers::generateErrorMessage(data->data_, loginErrors::errorCode::COULD_NOT_CONNECT_TO_LOBBY_SERVER);
                        data->do_write(0x24);
                        return;
                    }
                }
            }
            else
            {
                if (auto data = session.view_session.get())
                {
                    // Send error message to the client.
                    loginHelpers::generateErrorMessage(data->data_, loginErrors::errorCode::UNABLE_TO_CONNECT_TO_WORLD_SERVER); // "Unable to connect to world server. Specified operation failed"
                    data->do_write(0x24);
                    return;
                }
            }

            unsigned char Hash[16] = {};
            md5(reinterpret_cast<uint8*>(&characterSelectionResponse), Hash, sizeof(lpkt_next_login));

            loginPackets::copyHashIntoPacket(characterSelectionResponse, Hash);

            if (auto data = session.view_session.get())
            {
                std::memcpy(data->data_, &characterSelectionResponse, sizeof(characterSelectionResponse));
                data->do_write(sizeof(characterSelectionResponse));

                data->socket_.lowest_layer().shutdown(asio::socket_base::shutdown_both); // Client waits for us to close the socket
                data->socket_.lowest_layer().close();
                session.view_session = nullptr;
            }

            if (settings::get<bool>("login.LOG_USER_IP"))
            {
                // Log clients IP info when player spawns into map server

                time_t rawtime{};
                tm     convertedTime{};
                time(&rawtime);
                _localtime_s(&convertedTime, &rawtime);

                char timeAndDate[128];
                strftime(timeAndDate, sizeof(timeAndDate), "%Y:%m:%d %H:%M:%S", &convertedTime);

                if (_sql->Query("INSERT INTO account_ip_record(login_time,accid,charid,client_ip) \
                            VALUES ('%s', %u, %u, '%s');",
                                timeAndDate, session.accountID, charid, loginHelpers::ip2str(accountIP)) == SQL_ERROR)
                {
                    ShowError("data_session: Could not write info to account_ip_record.");
                }
            }

            ShowInfo(fmt::format("data_session: client {} finished work with lobbyview", loginHelpers::ip2str(accountIP)));
        }
        break;
        case 0xFE: // 254
        {
            // Reply with nothing to keep xiloader spinning, may not be needed.
            if (auto data = session.data_session.get())
            {
                data->do_write(0);
            }
        }
        break;
    }
}

void data_session::handle_error(std::error_code ec, std::shared_ptr<handler_session> self)
{
    if (self->sessionHash != "")
    {
        auto& map = loginHelpers::getAuthenticatedSessions()[self->ipAddress];
        auto  it  = map.find(self->sessionHash);

        if (it != map.end())
        {
            session_t& session = it->second;
            if (session.data_session.get())
            {
                session.data_session = nullptr;
            }

            if (session.data_session == nullptr && session.view_session == nullptr)
            {
                // Remove entry if needs to be
                map.erase(it);

                // Remove IP from map if it's the last entry
                auto& sessions = loginHelpers::getAuthenticatedSessions();
                if (sessions[self->ipAddress].size() == 1)
                {
                    sessions.erase(sessions.begin());
                }
            }
        }
    }
}
