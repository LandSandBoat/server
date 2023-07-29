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

#include "auth_session.h"

#include "common/socket.h" // for ref<T>

void auth_session::start()
{
    auto self(shared_from_this());
    if (socket_.lowest_layer().is_open())
    {
        // clang-format off
        socket_.async_handshake(asio::ssl::stream_base::server,
        [this, self](std::error_code ec)
        {
            if (!ec)
            {
                do_read();
            }
            else
            {
                ShowWarning(fmt::format("Error from {}: ({}), {}", ipAddress, ec.value(), ec.message()));
                ShowWarning("Failed to handshake!");
                socket_.next_layer().close();
            }
        });
        // clang-format on
    }
}

void auth_session::do_read()
{
    auto self(shared_from_this());
    // clang-format off
    socket_.async_read_some(asio::buffer(data_, max_length),
    [this, self](std::error_code ec, std::size_t length)
    {
        if (!ec)
        {
            read_func();
        }
        else
        {
            DebugSockets(fmt::format("async_read_some error in auth_session from IP {}:\n{}", ipAddress, ec.message()));
            handle_error(ec, self);
        }
    });
    // clang-format on
}

void auth_session::read_func()
{
    auto newModeFlag = ref<uint8>(data_, 0) == 0xFF;
    if (!newModeFlag)
    {
        ShowDebug("Old xiloader connected. Not supported.");
        ref<uint8>(data_, 0) = LOGIN_ERROR;
        do_write(1);
        return;
    }

    // Feature flags from xiloader are sent over on the 2nd byte+

    char usernameBuffer[17] = {};
    char passwordBuffer[33] = {};

    std::memcpy(usernameBuffer, data_ + 0x09, 16);
    std::memcpy(passwordBuffer, data_ + 0x19, 32);
    // 1 byte of command at 0x39
    // 17 bytes of operator specific space starting at 0x50. This region will be used for anything server operators may install into custom launchers.
    std::string version(data_ + 0x61, 5);

    std::string username(usernameBuffer, 16);
    std::string password(passwordBuffer, 32);

    if (strncmp(version.c_str(), SUPPORTED_XILOADER_VERSION, 5) != 0)
    {
        ref<uint8>(data_, 0) = LOGIN_ERROR_VERSION_UNSUPPORTED;

        do_write(1);
        return;
    }

    int8 code = ref<uint8>(data_, 0x39);

    DebugSockets(fmt::format("auth code: {} from {}", code, ipAddress));

    // data check
    if (loginHelpers::check_string(username, 16) && loginHelpers::check_string(password, 32))
    {
        ShowWarning(fmt::format("login_parse: bad username or password from {}", ipAddress));
        return;
    }
    auto sql = std::make_unique<SqlConnection>();

    char escaped_name[16 * 2 + 1] = {};
    char escaped_pass[32 * 2 + 1] = {};

    sql->EscapeString(escaped_name, username.c_str());
    sql->EscapeString(escaped_pass, password.c_str());

    username = escaped_name;
    password = escaped_pass;

    switch (code)
    {
        case 0:
        {
            // no-op. This can happen if control + C is pressed in xiloader.
            break;
        }
        case LOGIN_ATTEMPT:
        {
            DebugSockets(fmt::format("LOGIN_ATTEMPT from {}", ipAddress));

            int32 ret = sql->Query("SELECT accounts.id,accounts.status FROM accounts WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')",
                                   escaped_name, escaped_pass);

            if (ret != SQL_ERROR && sql->NumRows() != 0)
            {
                ret = sql->NextRow();

                uint32 accountID = sql->GetUIntData(0);
                uint32 status    = sql->GetUIntData(1);

                if (status & ACCOUNT_STATUS_CODE::NORMAL)
                {
                    sql->Query("UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d", accountID);

                    ret = sql->Query("SELECT charid, server_addr, server_port \
                                        FROM accounts_sessions JOIN accounts \
                                        ON accounts_sessions.accid = accounts.id \
                                        WHERE accounts.id = %d;",
                                     accountID);

                    if (ret != SQL_ERROR && sql->NumRows() == 1)
                    {
                        while (sql->NextRow() == SQL_SUCCESS)
                        {
                            /*uint32 charid = sql->GetUIntData(0);
                            uint64 ip     = sql->GetUIntData(1);
                            uint64 port   = sql->GetUIntData(2);

                            ip |= (port << 32);

                            zmq::message_t chardata(sizeof(charid));
                            ref<uint32>((uint8*)chardata.data(), 0) = charid;
                            zmq::message_t empty(0);

                            // TODO: MSG_LOGIN is a no-op in message_server.cpp,
                            //     : so sending this does nothing?
                            //     : But in the client (message.cpp), it _could_
                            //     : be used to clear out lingering PChar data.
                            queue_message(ipp, MSG_LOGIN, &chardata, &empty);
                            */
                        }
                    }

                    // TODO: Lock out same account logging in multiple times. Can check data/view session existence on same IP/account?
                    // Not a real problem because the account is locked out when a character is logged in.

                    /* fmtQuery = "SELECT charid \
                            FROM accounts_sessions \
                            WHERE accid = %u LIMIT 1;";

                    if (sql->Query(fmtQuery, accountID) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                    {
                        // TODO: kick player out of map server if already logged in
                        // uint32 charid = sql->GetUIntData(0);

                        // This error message doesn't work when sent this way. Unknown how to transmit "1039" error message to a client already logged in.
                        // session_t& authenticatedSession = get_authenticated_session(socket_, session.sentAccountID);
                        // if (auto data = authenticatedSession.data_session)
                        // {
                        //  generateErrorMessage(data->data_, 139);
                        //  data->do_write(0x24);
                        //  return;
                        //}
                        ref<uint8>(data_, 0) = LOGIN_ERROR_ALREADY_LOGGED_IN;
                        do_write(1);
                        return;
                    }*/

                    // Success
                    std::memset(data_, 0, 49);
                    ref<uint8>(data_, 0)  = LOGIN_SUCCESS;
                    ref<uint32>(data_, 1) = accountID;

                    unsigned char hash[16];
                    uint32        hashData = std::time(nullptr) ^ getpid();
                    md5(reinterpret_cast<uint8*>(&hashData), hash, sizeof(hashData));
                    std::memcpy(data_ + 5, hash, 16);

                    do_write(21);

                    auto& session          = loginHelpers::get_authenticated_session(ipAddress, std::string(reinterpret_cast<const char*>(hash), sizeof(hash)));
                    session.accountID      = accountID;
                    session.authorizedTime = server_clock::now();
                }
                else if (status & ACCOUNT_STATUS_CODE::BANNED)
                {
                    ref<uint8>(data_, 0) = LOGIN_FAIL;
                    do_write(33);
                }
            }
            else // No account match
            {
                ref<uint8>(data_, 0) = LOGIN_ERROR;
                do_write(1);
            }
        }
        break;
        case LOGIN_CREATE:
        {
            DebugSockets(fmt::format("LOGIN_CREATE from {}", ipAddress));
            // check if account creation is disabled
            if (!settings::get<bool>("login.ACCOUNT_CREATION"))
            {
                ShowWarning(fmt::format("login_parse: New account attempt <{}> but is disabled in settings.",
                                        escaped_name));
                ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE_DISABLED;
                do_write(1);
                return;
            }

            // looking for same login
            if (sql->Query("SELECT accounts.id FROM accounts WHERE accounts.login = '%s'", escaped_name) == SQL_ERROR)
            {
                ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                do_write(1);
                return;
            }

            if (sql->NumRows() == 0)
            {
                // creating new account_id
                uint32 accid = 0;

                if (sql->Query("SELECT max(accounts.id) FROM accounts;") != SQL_ERROR && sql->NumRows() != 0)
                {
                    sql->NextRow();

                    accid = sql->GetUIntData(0) + 1;
                }
                else
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                    do_write(1);
                    return;
                }

                accid = (accid < 1000 ? 1000 : accid);

                // creating new account
                time_t timecreate{};
                tm     timecreateinfo{};

                time(&timecreate);
                _localtime_s(&timecreateinfo, &timecreate);

                char strtimecreate[128];
                strftime(strtimecreate, sizeof(strtimecreate), "%Y:%m:%d %H:%M:%S", &timecreateinfo);

                if (sql->Query("INSERT INTO accounts(id,login,password,timecreate,timelastmodify,status,priv) \
                                VALUES(%d,'%s',PASSWORD('%s'),'%s',NULL,%d,%d);",
                               accid, escaped_name, escaped_pass, strtimecreate, ACCOUNT_STATUS_CODE::NORMAL, ACCOUNT_PRIVILEGE_CODE::USER) == SQL_ERROR)
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                    do_write(1);
                    return;
                }

                ref<uint8>(data_, 0) = LOGIN_SUCCESS_CREATE;
                do_write(1);
                return;
            }
            else
            {
                ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE_TAKEN;
                do_write(1);
                return;
            }
            break;
        }
        case LOGIN_CHANGE_PASSWORD:
        {
            int32 ret = sql->Query("SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')",
                                   escaped_name, escaped_pass);
            if (ret == SQL_ERROR || sql->NumRows() == 0)
            {
                ShowWarning(fmt::format("login_parse: user <{}> could not be found using the provided information. Aborting.", escaped_name));
                ref<uint8>(data_, 0) = LOGIN_ERROR;
                do_write(1);
                return;
            }

            ret = sql->NextRow();

            uint32 accid  = sql->GetUIntData(0);
            uint8  status = (uint8)sql->GetUIntData(1);

            if (status & ACCOUNT_STATUS_CODE::BANNED)
            {
                ShowInfo(fmt::format("login_parse: banned user <{}> detected. Aborting.", escaped_name));
                ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                do_write(1);
            }

            if (status & ACCOUNT_STATUS_CODE::NORMAL)
            {
                // Account info verified, grab password
                std::string updated_password(data_ + 0x40, 32);

                if (updated_password == "")
                {
                    ShowWarning(fmt::format("login_parse: Empty password; Could not update password for user <{}>.", escaped_name));
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    do_write(1);
                    return;
                }

                char escaped_updated_password[32 * 2 + 1];
                sql->EscapeString(escaped_updated_password, updated_password.c_str());

                sql->Query("UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d", accid);

                ret = sql->Query("UPDATE accounts SET accounts.password = PASSWORD('%s') WHERE accounts.id = %d",
                                 escaped_updated_password, accid);
                if (ret == SQL_ERROR)
                {
                    ShowWarning(fmt::format("login_parse: Error trying to update password in database for user <{}>.", escaped_name));
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    do_write(1);
                    return;
                }

                memset(data_, 0, 33);
                ref<uint8>(data_, 0) = LOGIN_SUCCESS_CHANGE_PASSWORD;
                do_write(33);

                ShowInfo(fmt::format("login_parse: password updated for account {} successfully.", accid));
                return;
            }
        }
        break;
        default:
        {
            ShowError(fmt::format("Unhandled auth code: {} from {}", code, ipAddress));
        }
        break;
    }
}

void auth_session::do_write(std::size_t length)
{
    auto self(shared_from_this());
    // clang-format off
    asio::async_write(socket_, asio::buffer(data_, length),
    [this, self](std::error_code ec, std::size_t /*length*/)
    {
        if (!ec)
        {
            write_func();
        }
        else
        {
            ShowError(ec.message());
        }
    });
    // clang-format on
}
