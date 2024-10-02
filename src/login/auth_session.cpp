﻿/*
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
#include "common/utils.h"

#include <bcrypt/BCrypt.hpp>

namespace
{
    constexpr int currentYear()
    {
        // clang-format off
        constexpr auto charToInt = [](char c)
        {
            return (c >= '0' && c <= '9') ? (c - '0') : 0;
        };
        // clang-format on

        constexpr const char* timestamp       = __TIMESTAMP__;             // "__TIMESTAMP__" is like "Mon Jan  2 15:04:05 2006"
        constexpr size_t      timestampLength = sizeof(__TIMESTAMP__) - 1; // Length of the timestamp string

        int year = 0;
        for (size_t i = timestampLength - 4; i < timestampLength; ++i)
        {
            year = year * 10 + charToInt(timestamp[i]);
        }

        return year;
    }

    constexpr bool isBcryptHash(const std::string& passHash)
    {
        return std::size(passHash) == 60 && passHash[0] == '$' && passHash[1] == '2' && (passHash[2] == 'a' || passHash[2] == 'b' || passHash[2] == 'y' || passHash[2] == 'x') && // bcrypt hash versions
            passHash[3] == '$';
    }
} // namespace

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
                auto errStr = fmt::format("Error from {}: (EC: {}), {}", ipAddress, ec.value(), ec.message());
                ShowWarning(errStr);
                ShowWarning("Failed to handshake!");
                if (errStr.find("wrong version number (SSL routines)") != std::string::npos)
                {
                    ShowWarning("This is likely due to the client using an outdated/incompatible version of xiloader.");
                    ShowWarning("Please make sure you're using the latest release: https://github.com/LandSandBoat/xiloader/releases");
                }
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

    // Only match on the first 3 characters of the version string
    // ie. 1.1.1 -> 1.1.x
    // Major.Minor.Patch
    // Major and minor version changes should be breaking, patch should not.
    if (strncmp(version.c_str(), SUPPORTED_XILOADER_VERSION, 3) != 0)
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
        ShowWarningFmt("login_parse: bad username or password from {}", ipAddress);
        return;
    }

    auto _sql = std::make_unique<SqlConnection>();

    char escaped_name[16 * 2 + 1] = {};
    char escaped_pass[32 * 2 + 1] = {};

    _sql->EscapeString(escaped_name, username.c_str());
    _sql->EscapeString(escaped_pass, password.c_str());

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

            // clang-format off
            auto passHash = [&]() -> std::string
            {
                auto ret = _sql->Query("SELECT accounts.password FROM accounts WHERE accounts.login = '%s'", username);
                if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    return _sql->GetStringData(0);
                }
                return "";
            }();
            // clang-format on

            // OLD PASSWORD HASH MIGRATION
            static_assert(currentYear() <= 2024, "Migration period for old password hashes has expired. Please simplify this code after 2024-12-31 or open an issue upstream to do so.");

            if (isBcryptHash(passHash))
            {
                // It's a BCrypt hash, so we can validate it.
                if (!BCrypt::validatePassword(password, passHash))
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR;
                    do_write(1);
                    return;
                }
            }
            else
            {
                // It's not a BCrypt hash, so we need to use Maria's PASSWORD() to check if the password is actually correct,
                // and then update the password to a BCrypt hash.
                auto ret = _sql->Query("SELECT PASSWORD('%s')", password);
                if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    if (_sql->GetStringData(0) != passHash)
                    {
                        ref<uint8>(data_, 0) = LOGIN_ERROR;
                        do_write(1);
                        return;
                    }
                    else
                    {
                        passHash = BCrypt::generateHash(password);
                        _sql->Query("UPDATE accounts SET accounts.password = '%s' WHERE accounts.login = '%s'", passHash.c_str(), username);

                        if (!BCrypt::validatePassword(password, passHash))
                        {
                            ref<uint8>(data_, 0) = LOGIN_ERROR;
                            do_write(1);
                            return;
                        }
                    }
                }
            }

            // We've validated the password by this point, get account info
            int32 ret = _sql->Query("SELECT accounts.id, accounts.status FROM accounts WHERE accounts.login = '%s'", username);
            if (ret != SQL_ERROR && _sql->NumRows() != 0)
            {
                ret = _sql->NextRow();

                uint32 accountID = _sql->GetUIntData(0);
                uint32 status    = _sql->GetUIntData(1);

                if (status & ACCOUNT_STATUS_CODE::NORMAL)
                {
                    _sql->Query("UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d", accountID);

                    ret = _sql->Query("SELECT charid, server_addr, server_port \
                                        FROM accounts_sessions JOIN accounts \
                                        ON accounts_sessions.accid = accounts.id \
                                        WHERE accounts.id = %d",
                                      accountID);

                    if (ret != SQL_ERROR && _sql->NumRows() == 1)
                    {
                        while (_sql->NextRow() == SQL_SUCCESS)
                        {
                            /*uint32 charid = _sql->GetUIntData(0);
                            uint64 ip     = _sql->GetUIntData(1);
                            uint64 port   = _sql->GetUIntData(2);

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
                            WHERE accid = %u LIMIT 1";

                    if (_sql->Query(fmtQuery, accountID) != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
                    {
                        // TODO: kick player out of map server if already logged in
                        // uint32 charid = _sql->GetUIntData(0);

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
                ShowWarningFmt("login_parse: New account attempt <{}> but is disabled in settings.",
                               username);
                ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE_DISABLED;
                do_write(1);
                return;
            }

            // looking for same login
            if (_sql->Query("SELECT accounts.id FROM accounts WHERE accounts.login = '%s'", username) == SQL_ERROR)
            {
                ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                do_write(1);
                return;
            }

            if (_sql->NumRows() == 0)
            {
                // creating new account_id
                uint32 accid = 0;

                if (_sql->Query("SELECT max(accounts.id) FROM accounts") != SQL_ERROR && _sql->NumRows() != 0)
                {
                    _sql->NextRow();

                    accid = _sql->GetUIntData(0) + 1;
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

                if (_sql->Query("INSERT INTO accounts(id,login,password,timecreate,timelastmodify,status,priv) \
                                VALUES(%d,'%s','%s','%s',NULL,%d,%d)",
                                accid, username, BCrypt::generateHash(escaped_pass), strtimecreate, ACCOUNT_STATUS_CODE::NORMAL, ACCOUNT_PRIVILEGE_CODE::USER)
                    == SQL_ERROR)
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
            // Look up and validate account password
            // clang-format off
            auto passHash = [&]() -> std::string
            {
                auto ret = _sql->Query("SELECT accounts.password FROM accounts WHERE accounts.login = '%s'", username);
                if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    return _sql->GetStringData(0);
                }
                return "";
            }();
            // clang-format on

            // OLD PASSWORD HASH MIGRATION
            static_assert(currentYear() <= 2024, "Migration period for old password hashes has expired. Please simplify this code after 2024-12-31 or open an issue upstream to do so.");

            if (isBcryptHash(passHash))
            {
                // It's a BCrypt hash, so we can validate it.
                if (!BCrypt::validatePassword(password, passHash))
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    do_write(1);
                    return;
                }
            }
            else
            {
                // It's not a BCrypt hash, so we need to use Maria's PASSWORD() to check if the password is actually correct,
                // and then update the password to a BCrypt hash.
                auto ret = _sql->Query("SELECT PASSWORD('%s')", password);
                if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    if (_sql->GetStringData(0) != passHash)
                    {
                        ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                        do_write(1);
                        return;
                    }
                    else
                    {
                        passHash = BCrypt::generateHash(password);
                        _sql->Query("UPDATE accounts SET accounts.password = '%s' WHERE accounts.login = '%s'", passHash.c_str(), username);

                        if (!BCrypt::validatePassword(password, passHash))
                        {
                            ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                            do_write(1);
                            return;
                        }
                    }
                }
            }

            int32 ret = _sql->Query("SELECT accounts.id, accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s'",
                                    username);
            if (ret == SQL_ERROR || _sql->NumRows() == 0)
            {
                ShowWarningFmt("login_parse: user <{}> could not be found using the provided information. Aborting.", username);
                ref<uint8>(data_, 0) = LOGIN_ERROR;
                do_write(1);
                return;
            }

            ret = _sql->NextRow();

            uint32 accid  = _sql->GetUIntData(0);
            uint8  status = (uint8)_sql->GetUIntData(1);

            if (status & ACCOUNT_STATUS_CODE::BANNED)
            {
                ShowInfoFmt("login_parse: banned user <{}> detected. Aborting.", username);
                ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                do_write(1);
            }

            if (status & ACCOUNT_STATUS_CODE::NORMAL)
            {
                // Account info verified, grab password
                std::string updated_password(data_ + 0x40, 32);

                if (updated_password == "")
                {
                    ShowWarningFmt("login_parse: Empty password; Could not update password for user <{}>.", username);
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    do_write(1);
                    return;
                }

                char escaped_updated_password[32 * 2 + 1];
                _sql->EscapeString(escaped_updated_password, updated_password.c_str());

                updated_password = escaped_updated_password;

                _sql->Query("UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d", accid);

                ret = _sql->Query("UPDATE accounts SET accounts.password = '%s' WHERE accounts.id = %d",
                                  BCrypt::generateHash(updated_password), accid);
                if (ret == SQL_ERROR)
                {
                    ShowWarningFmt("login_parse: Error trying to update password in database for user <{}>.", username);
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    do_write(1);
                    return;
                }

                memset(data_, 0, 33);
                ref<uint8>(data_, 0) = LOGIN_SUCCESS_CHANGE_PASSWORD;
                do_write(33);

                ShowInfo("login_parse: password updated for account {} successfully.", accid);
                return;
            }
        }
        break;
        default:
        {
            ShowError("Unhandled auth code: {} from {}", code, ipAddress);
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
