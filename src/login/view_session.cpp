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

#include "view_session.h"

#include <common/lua.h>
#include <common/settings.h>
#include <common/utils.h>

#include "login_packets.h"

void view_session::read_func()
{
    uint8 code = ref<uint8>(data_, 8);

    std::string sessionHash = loginHelpers::getHashFromPacket(ipAddress, data_);

    if (sessionHash == "")
    {
        ShowWarning(fmt::format("Session requested without valid sessionHash from {}", ipAddress));
        return;
    }
    session_t& session = loginHelpers::get_authenticated_session(ipAddress, sessionHash);
    if (!session.view_session)
    {
        session.view_session = std::make_shared<view_session>(std::forward<asio::ssl::stream<asio::ip::tcp::socket>>(socket_));
    }
    session.view_session->sessionHash = sessionHash;

    DebugSockets(fmt::format("view code: {}", code));

    switch (code)
    {
        case 0x07: // 07: "Notifying lobby server of current selections."
        {
            auto requestedCharacterID                 = ref<uint32>(data_, 28);
            char requestedCharacter[PacketNameLength] = {};
            std::memcpy(&requestedCharacter, data_ + 36, PacketNameLength - 1);

            auto _sql = std::make_unique<SqlConnection>();

            uint32 accountID = 0;
            int32  ret       = _sql->Query("SELECT accid FROM chars WHERE charid = %u and charname = '%s' LIMIT 1;",
                                           requestedCharacterID, requestedCharacter);
            if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                accountID                    = _sql->GetUIntData(0);
                session.requestedCharacterID = requestedCharacterID;
            }
            else
            {
                ShowError(fmt::format("Account ID {} tried to select a character id with a mismatched character name.", session.accountID));
                socket_.lowest_layer().close();
                return;
            }

            if (accountID != session.accountID)
            {
                ShowError(fmt::format("Account ID {} tried to login as character not in their account.", session.accountID));
                socket_.lowest_layer().close();
                return;
            }

            if (auto data = session.data_session)
            {
                std::memset(data->data_, 0, 0x05);
                data->data_[0] = 0x02;
                data->do_write(0x05);
            }
        }
        break;
        case 0x14: // 20: "Deleting from lobby server"
        {
            auto _sql = std::make_unique<SqlConnection>();
            if (!settings::get<bool>("login.CHARACTER_DELETION"))
            {
                loginHelpers::generateErrorMessage(data_, loginErrors::errorCode::COULD_NOT_CONNECT_TO_LOBBY_SERVER);
                do_write(0x24);
                return;
            }

            memset(data_, 0, 0x20);
            data_[0] = 0x20; // size

            data_[4] = 0x49; // I
            data_[5] = 0x58; // X
            data_[6] = 0x46; // F
            data_[7] = 0x46; // F

            data_[8] = 0x03; // result

            unsigned char hash[16];

            md5(reinterpret_cast<uint8*>(data_), hash, 0x20);
            std::memcpy(data_ + 12, hash, 16);

            do_write(0x20);

            uint32 CharID = ref<uint32>(data_, 0x20);

            ShowInfo(fmt::format("attempt to delete char:<{}> from ip:<{}>",
                                 CharID, ipAddress));

            uint32 accountID = 0;
            int32  ret       = _sql->Query("SELECT accid FROM chars WHERE charid = %u LIMIT 1;", CharID);

            if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                accountID = _sql->GetUIntData(0);
            }

            if (accountID != session.accountID)
            {
                ShowError(fmt::format("Account ID {} tried to delete character not in their account. (Note: there is a known issue that the client does not send the whole ID for characters above ID 65535 and this may not be their fault.)", session.accountID));
                socket_.lowest_layer().close();
                return;
            }

            // Perform character deletion.
            // Instead of performing an actual character deletion, we simply set accid to 0, and original_accid to old accid.
            // This allows character recovery.

            _sql->Query("UPDATE chars SET accid = 0, original_accid = %i WHERE charid = %i AND accid = %i",
                        session.accountID, CharID, session.accountID);
        }
        break;
        case 0x21: // 33: Registering character name onto the lobby server
        {
            // creating new char
            if (loginHelpers::createCharacter(session, data_) == -1)
            {
                socket_.lowest_layer().close();
                return;
            }

            session.justCreatedNewChar = true;
            ShowInfo(fmt::format("char <{}> was successfully created on account {}", session.requestedNewCharacterName, session.accountID));

            memset(data_, 0, 0x20);

            data_[0] = 0x20; // size

            data_[4] = 0x49; // I
            data_[5] = 0x58; // X
            data_[6] = 0x46; // F
            data_[7] = 0x46; // F

            data_[8] = 0x03; // result

            unsigned char hash[16];

            md5(reinterpret_cast<uint8*>(data_), hash, 0x20);
            std::memcpy(data_ + 12, hash, 16);

            do_write(0x20);
        }
        break;
        case 0x22: // 34: Checking name and Gold World Pass
        {
            // block creation of character if in maintenance mode or generally disabled
            auto maintMode               = settings::get<uint8>("login.MAINT_MODE");
            auto enableCharacterCreation = settings::get<bool>("login.CHARACTER_CREATION");
            if (maintMode > 0 || !enableCharacterCreation)
            {
                loginHelpers::generateErrorMessage(data_, loginErrors::errorCode::FAILED_TO_REGISTER_WITH_THE_NAME_SERVER);
                do_write(0x24);
                return;
            }
            else
            {
                auto _sql = std::make_unique<SqlConnection>();

                // creating new char
                char CharName[PacketNameLength] = {};
                std::memcpy(CharName, data_ + 32, PacketNameLength - 1);

                // Sanitize name
                char escapedCharName[16 * 2 + 1];
                _sql->EscapeString(escapedCharName, CharName);

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
                if (_sql->Query("SELECT charname FROM chars WHERE charname LIKE '%s'", escapedCharName) == SQL_ERROR)
                {
                    invalidNameReason = "Internal entity name query failed.";
                }
                else if (_sql->NumRows() != 0)
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

                    if (_sql->Query(query, nameStr) == SQL_ERROR)
                    {
                        invalidNameReason = "Internal entity name query failed";
                    }
                    else if (_sql->NumRows() != 0)
                    {
                        invalidNameReason = "Name already in use.";
                    }
                }

                // (optional) Check if the name contains any words on the bad word list
                auto loginSettingsTable = lua["xi"]["settings"]["login"].get<sol::table>();
                if (auto badWordsList = loginSettingsTable.get_or<sol::table>("BANNED_WORDS_LIST", sol::lua_nil); badWordsList.valid())
                {
                    auto potentialName = to_upper(nameStr);
                    for (auto const& entry : badWordsList)
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
                    ShowWarning(fmt::format("new character name error <{}>: {}", str(CharName), *invalidNameReason));

                    // Send error code:
                    // The character name you entered is unavailable. Please choose another name.
                    // TODO: This message is displayed in Japanese, needs fixing.
                    loginHelpers::generateErrorMessage(data_, loginErrors::errorCode::CHARACTER_NAME_UNAVAILABLE);
                    do_write(0x24);
                    return;
                }
                else
                {
                    // copy charname
                    session.requestedNewCharacterName = CharName;

                    memset(data_, 0, 0x20);
                    data_[0] = 0x20; // size

                    data_[4] = 0x49; // I
                    data_[5] = 0x58; // X
                    data_[6] = 0x46; // F
                    data_[7] = 0x46; // F

                    data_[8] = 0x03; // result

                    unsigned char hash[16];

                    md5(reinterpret_cast<uint8*>(data_), hash, 0x20);
                    std::memcpy(data_ + 12, hash, 16);

                    do_write(0x20);
                }
            }
        }
        break;
        case 0x26: // 38: Version + Expansions, "Setting up connection."
        {
            std::string client_ver_data((data_ + 0x74), 6); // Full length is 10 but we drop last 4. This contains "E" in the english client. Perhaps this can be used as a hint for language?
            client_ver_data = client_ver_data + "xx_x";     // And then we replace those last 4
            DebugSockets(fmt::format("Version: {} from {}", client_ver_data, ipAddress));

            std::string expected_version(settings::get<std::string>("login.CLIENT_VER"), 0, 6); // Same deal here!
            expected_version     = expected_version + "xx_x";
            bool versionMismatch = expected_version != client_ver_data;
            bool fatalMismatch   = false;

            if (versionMismatch)
            {
                ShowError(fmt::format("view_session: Account {} has incorrect client version: got {}, expected {}", session.accountID, client_ver_data, expected_version));

                switch (settings::get<uint8>("login.VER_LOCK"))
                {
                    // enabled
                    case 1:
                        if (expected_version < client_ver_data)
                        {
                            ShowError("view_session: The server must be updated to support this client version");
                        }
                        else
                        {
                            ShowError("view_session: The client must be updated to support this server version");
                        }
                        fatalMismatch = true;
                        break;
                    // enabled greater than or equal
                    case 2:
                        if (expected_version > client_ver_data)
                        {
                            ShowError("view_session: The client must be updated to support this server version");
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
                if (auto data = session.view_session.get())
                {
                    loginHelpers::generateErrorMessage(data->data_, loginErrors::errorCode::GAMES_DATA_HAS_BEEN_UPDATED); // "The games data has been updated"
                    data->do_write(0x24);
                    return;
                }
            }

            std::array<uint8, 0x28> packet = {};

            packet[0] = 0x28; // size

            packet[4] = 0x49; // I
            packet[5] = 0x58; // X
            packet[6] = 0x46; // F
            packet[7] = 0x46; // F

            packet[8] = 0x05; // result

            // Magic
            packet[28] = 0x4F;
            packet[29] = 0xE0;
            packet[30] = 0x5D;
            packet[31] = 0xAD;

            ref<uint16>(packet.data(), 32) = loginHelpers::generateExpansionBitmask();
            ref<uint16>(packet.data(), 36) = loginHelpers::generateFeatureBitmask();

            std::memset(data_, 0, 0x28);
            std::memcpy(data_, packet.data(), 0x28);

            // Hash the packet data and then write the value of the hash into the packet.
            unsigned char hash[16];
            md5(reinterpret_cast<uint8*>(data_), hash, 0x28);
            std::memcpy(data_ + 12, hash, 16);

            DebugSockets("view_session: Sending version and expansions info to account %d", session.accountID);

            if (auto data = session.view_session.get())
            {
                std::memcpy(data->data_, data_, 0x28);
                data->do_write(0x28);
            }
        }
        break;
        case 0x1F: // 31: "Acquiring Player Data"
        {
            if (auto data = session.data_session.get())
            {
                std::memset(data->data_, 0, 5);
                data->data_[0] = 0x01;
                data->do_write(0x05);
            }
            else
            {
                loginHelpers::generateErrorMessage(data_, loginErrors::errorCode::COULD_NOT_CONNECT_TO_LOBBY_SERVER); // "Could not connect to lobby server.\nPlease check this title's news for announcements."
                do_write(0x24);                                                                                       // This used to error, but this case is probably not valid after sessionHash. // TODO: is this this else block still needed?
                return;
            }
        }
        break;
        case 0x24: // 36: "Acquiring FINAL FANTASY XI server data"
        {
            std::memset(data_, 0, 0x40);
            auto serverName = settings::get<std::string>("main.SERVER_NAME");

            lpkt_world_list worldList = {};
            worldList.terminator      = loginPackets::getTerminator();
            worldList.command         = 0x23;

            loginPackets::clearIdentifier(worldList);

            // Send client 1 world
            worldList.sumofworld = 0x01;

            // Setup world id 0x20 with the server name from settings
            worldList.world_name[0].no = 0x20;
            std::memcpy(worldList.world_name[0].name, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

            if (auto data = session.view_session.get())
            {
                worldList.packet_size = sizeof(packet_t) + sizeof(uint32_t) + sizeof(lpkt_world_name) * worldList.sumofworld;

                unsigned char Hash[16];
                md5(reinterpret_cast<uint8*>(&worldList), Hash, worldList.packet_size);
                loginPackets::copyHashIntoPacket(worldList, Hash);

                std::memcpy(data->data_, &worldList, worldList.packet_size);
                data->do_write(worldList.packet_size);
            }
        }
        break;
    }
}

void view_session::handle_error(std::error_code ec, std::shared_ptr<handler_session> self)
{
    if (self->sessionHash != "")
    {
        auto& map = loginHelpers::getAuthenticatedSessions()[self->ipAddress];
        auto  it  = map.find(self->sessionHash);

        if (it != map.end())
        {
            session_t& session = it->second;
            if (session.view_session.get())
            {
                session.view_session = nullptr;
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
