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

#include "common/ipc.h"
#include "common/utils.h"
#include "otp_helpers.h"

#include <bcrypt/BCrypt.hpp>

#include <nlohmann/json.hpp>
using json = nlohmann::json;

namespace
{
    constexpr bool isBcryptHash(const std::string& passHash)
    {
        return std::size(passHash) == 60 &&
               passHash[0] == '$' &&
               passHash[1] == '2' &&
               (passHash[2] == 'a' || passHash[2] == 'b' || passHash[2] == 'y' || passHash[2] == 'x') && // bcrypt hash versions
               passHash[3] == '$';
    }
} // namespace

void auth_session::start()
{
    if (socket_.lowest_layer().is_open())
    {
        // clang-format off
        socket_.async_handshake(asio::ssl::stream_base::server,
        [this, self = shared_from_this()](std::error_code ec)
        {
            if (!ec)
            {
                do_read();
            }
            else
            {
                const auto errStr = fmt::format("Error from {}: (EC: {}), {}", ipAddress, ec.value(), ec.message());
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
    std::memset(buffer_.data(), 0, buffer_.size());

    // clang-format off
    socket_.async_read_some(asio::buffer(buffer_.data(), buffer_.size()),
    [this, self = shared_from_this()](std::error_code ec, std::size_t length)
    {
        if (!ec)
        {
            read_func();
        }
        else
        {
            DebugSockets(fmt::format("async_read_some error in auth_session from IP {} ({}: {})", ipAddress, ec.value(), ec.message()));
            handle_error(ec, self);
        }
    });
    // clang-format on
}

void auth_session::read_func()
{
    const auto jsonBuffer = nlohmann::json::parse(buffer_, nullptr, false);

    const auto sendJsonAsBuffer = [&](const json& json_)
    {
        std::string jsonString       = json_.dump();
        const char* jsonStringBuffer = jsonString.c_str();
        size_t      jsonStringSize   = strlen(jsonStringBuffer);

        std::memset(buffer_.data(), 0, buffer_.size());
        std::memcpy(buffer_.data(), jsonStringBuffer, jsonStringSize);

        do_write(jsonStringSize);
    };

    const auto sendLoginResult = [&](const login_result errorCode, const uint8 len)
    {
        json loginErrorCodeReply;
        loginErrorCodeReply["result"] = errorCode; // "old style" backwards compatible error code

        sendJsonAsBuffer(loginErrorCodeReply);
    };

    const auto sendJsonOnlyErrorMessage = [&](const std::string& errorMessage)
    {
        json loginErrorCodeReply;
        loginErrorCodeReply["error_message"] = errorMessage;

        sendJsonAsBuffer(loginErrorCodeReply);
    };

    if (jsonBuffer.is_discarded()) // not json
    {
        const auto newModeFlag = ref<uint8>(buffer_.data(), 0) == 0xFF;
        if (!newModeFlag) // Ancient, original xiloader pre-sessionhash
        {
            ref<uint8>(buffer_.data(), 0) = static_cast<uint8>(login_result::LOGIN_ERROR);

            do_write(1);
        }
        else // old non-json xiloader
        {
            ref<uint8>(buffer_.data(), 0) = static_cast<uint8>(login_result::LOGIN_ERROR_VERSION_UNSUPPORTED);

            do_write(1);
        }

        // close socket
        socket_.lowest_layer().shutdown(asio::socket_base::shutdown_both);
        socket_.lowest_layer().close();
        return;
    }

    int8                   code             = loginHelpers::jsonGet<int8>(jsonBuffer, "command").value_or(0);
    std::string            username         = loginHelpers::jsonGet<std::string>(jsonBuffer, "username").value_or("");
    std::string            password         = loginHelpers::jsonGet<std::string>(jsonBuffer, "password").value_or("");
    std::string            updated_password = loginHelpers::jsonGet<std::string>(jsonBuffer, "new_password").value_or("");
    std::string            otp              = loginHelpers::jsonGet<std::string>(jsonBuffer, "otp").value_or("");
    std::array<uint8_t, 3> version          = loginHelpers::jsonGet<uint8, 3>(jsonBuffer, "version").value_or(std::array<uint8_t, 3>{ 0, 0, 0 });

    // Check major.minor but ignore trivial
    if (version[0] != SupportedXiloaderVersion[0] || version[1] != SupportedXiloaderVersion[1])
    {
        std::string errorMessage = fmt::format("Your xiloader is too old.\nPlease update to version '{}.{}.x'.\nYour client reported '{}.{}.{}'.", SupportedXiloaderVersion[0], SupportedXiloaderVersion[1], version[0], version[1], version[2]);
        sendJsonOnlyErrorMessage(errorMessage);
        return;
    }

    DebugSockets(fmt::format("auth code: {} from {}", code, ipAddress));

    // data checks
    if (loginHelpers::isStringMalformed(username, 16))
    {
        ShowWarningFmt("login_parse: malformed username from {}", ipAddress);
        return;
    }

    if (loginHelpers::isStringMalformed(password, 32))
    {
        ShowWarningFmt("login_parse: malformed password from {}", ipAddress);
        return;
    }

    switch (static_cast<login_cmd>(code))
    {
        case login_cmd::LOGIN_NOOP:
        {
            // no-op. This can happen if control + C is pressed in xiloader.
            break;
        }
        case login_cmd::LOGIN_ATTEMPT:
        {
            DebugSockets(fmt::format("LOGIN_ATTEMPT from {}", ipAddress));

            // Look up and validate account password
            if (!validatePassword(username, password))
            {
                sendLoginResult(login_result::LOGIN_ERROR, 1);
                return;
            }

            if (otpHelpers::doesAccountNeedOTP(username, "TOTP"))
            {
                if (!otpHelpers::validateTOTP(otp, otpHelpers::getAccountSecret(username, "TOTP")))
                {
                    sendLoginResult(login_result::LOGIN_ERROR, 1);
                    return;
                }
            }

            // We've validated the password by this point, get account info
            const auto rset = db::preparedStmt("SELECT accounts.id, accounts.status FROM accounts WHERE accounts.login = ?", username);
            if (rset && rset->rowsCount() != 0 && rset->next())
            {
                uint32 accountID = rset->get<uint32>("id");
                uint32 status    = rset->get<uint32>("status");

                if (status & ACCOUNT_STATUS_CODE::NORMAL)
                {
                    db::preparedStmt("UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = ?", accountID);

                    const auto payload = ipc::toBytesWithHeader(ipc::AccountLogin{
                        .accountId = accountID,
                    });

                    zmqDealerWrapper_.outgoingQueue_.enqueue(zmq::message_t(payload.data(), payload.size()));

                    // TODO: Lock out same account logging in multiple times. Can check data/view session existence on same IP/account?
                    // Not a real problem because the account is locked out when a character is logged in.

                    /*
                    const auto rset = db::preparedStmt("SELECT charid "
                            "FROM accounts_sessions "
                            "WHERE accid = ? LIMIT 1", accountID);
                    if (rset && rset->rowsCount() != 0 && rset->next())
                    {
                        // TODO: kick player out of map server if already logged in
                        // uint32 charid = rset->get<uint32>("charid");

                        // This error message doesn't work when sent this way. Unknown how to transmit "1039" error message to a client already logged in.
                        // session_t& authenticatedSession = get_authenticated_session(socket_, session.sentAccountID);
                        // if (auto data = authenticatedSession.buffer_.data()session)
                        // {
                        //  generateErrorMessage(data->buffer_.data(), 139);
                        //  data->do_write(0x24);
                        //  return;
                        //}
                        ref<uint8>(buffer_.data(), 0) = LOGIN_ERROR_ALREADY_LOGGED_IN;
                        do_write(1);
                        return;
                    }
                    */

                    // Success
                    unsigned char hash[16];
                    uint32        hashData = earth_time::timestamp() ^ getpid();
                    md5(reinterpret_cast<uint8*>(&hashData), hash, sizeof(hashData));

                    json loginSuccessReply;
                    loginSuccessReply["result"]       = static_cast<uint8>(login_result::LOGIN_SUCCESS);
                    loginSuccessReply["account_id"]   = accountID;
                    loginSuccessReply["session_hash"] = hash; // This has to be sent as an array, json.dump() tries to convert to UTF which fails

                    sendJsonAsBuffer(loginSuccessReply);

                    auto& session          = loginHelpers::get_authenticated_session(ipAddress, asStringFromUntrustedSource(hash, sizeof(hash)));
                    session.accountID      = accountID;
                    session.authorizedTime = timer::now();
                }
                else if (status & ACCOUNT_STATUS_CODE::BANNED)
                {
                    sendLoginResult(login_result::LOGIN_FAIL, 33);
                }
            }
            else // No account match
            {
                sendLoginResult(login_result::LOGIN_FAIL, 1);
            }
        }
        break;
        case login_cmd::LOGIN_CREATE:
        {
            DebugSockets(fmt::format("LOGIN_CREATE from {}", ipAddress));

            // check if account creation is disabled
            if (!settings::get<bool>("login.ACCOUNT_CREATION"))
            {
                ShowWarningFmt("login_parse: New account attempt <{}> but is disabled in settings.",
                               username);
                sendLoginResult(login_result::LOGIN_ERROR_CREATE_DISABLED, 1);
                return;
            }

            // looking for same login
            const auto rset = db::preparedStmt("SELECT accounts.id FROM accounts WHERE accounts.login = ?", username);
            if (!rset)
            {
                sendLoginResult(login_result::LOGIN_ERROR_CREATE, 1);
                return;
            }

            if (rset->rowsCount() == 0)
            {
                // creating new account_id
                uint32 accid = 0;

                const auto rset1 = db::preparedStmt("SELECT COALESCE(MAX(accounts.id), 0) AS max_id FROM accounts");
                if (rset1 && rset1->rowsCount() != 0 && rset1->next())
                {
                    accid = rset1->get<uint32>("max_id") + 1;
                }
                else
                {
                    sendLoginResult(login_result::LOGIN_ERROR_CREATE, 1);
                    return;
                }

                accid = (accid < 1000 ? 1000 : accid);

                // creating new account
                std::tm timecreateinfo = earth_time::to_local_tm();

                char strtimecreate[128];
                strftime(strtimecreate, sizeof(strtimecreate), "%Y:%m:%d %H:%M:%S", &timecreateinfo);

                const auto rset2 = db::preparedStmt("INSERT INTO accounts(id,login,password,timecreate,timelastmodify,status,priv) "
                                                    "VALUES(?, ?, ?, ?, NULL, ?, ?)",
                                                    accid, username, BCrypt::generateHash(password), strtimecreate, static_cast<uint8>(ACCOUNT_STATUS_CODE::NORMAL), static_cast<uint8>(ACCOUNT_PRIVILEGE_CODE::USER));
                if (!rset2)
                {
                    sendLoginResult(login_result::LOGIN_ERROR_CREATE, 1);
                    return;
                }

                sendLoginResult(login_result::LOGIN_SUCCESS_CREATE, 1);
                return;
            }
            else
            {
                sendLoginResult(login_result::LOGIN_ERROR_CREATE_TAKEN, 1);
                return;
            }
            break;
        }
        case login_cmd::LOGIN_CHANGE_PASSWORD:
        {
            // Look up and validate account password
            if (!validatePassword(username, password))
            {
                sendLoginResult(login_result::LOGIN_ERROR_CHANGE_PASSWORD, 1);
                return;
            }

            if (otpHelpers::doesAccountNeedOTP(username, "TOTP"))
            {
                if (!otpHelpers::validateTOTP(otp, otpHelpers::getAccountSecret(username, "TOTP")))
                {
                    sendLoginResult(login_result::LOGIN_ERROR_CHANGE_PASSWORD, 1);
                    return;
                }
            }

            // Is this check redundant?
            const auto rset = db::preparedStmt("SELECT accounts.id, accounts.status "
                                               "FROM accounts "
                                               "WHERE accounts.login = ?",
                                               username);
            if (rset == nullptr || rset->rowsCount() == 0)
            {
                ShowWarningFmt("login_parse: user <{}> could not be found using the provided information. Aborting.", username);

                sendLoginResult(login_result::LOGIN_ERROR, 1);
                return;
            }

            rset->next();

            uint32 accid  = rset->get<uint32>("id");
            uint8  status = rset->get<uint8>("status");

            if (status & ACCOUNT_STATUS_CODE::BANNED)
            {
                ShowInfoFmt("login_parse: banned user <{}> detected. Aborting.", username);

                sendLoginResult(login_result::LOGIN_ERROR_CHANGE_PASSWORD, 1);
            }

            if (status & ACCOUNT_STATUS_CODE::NORMAL)
            {
                // Account info verified, update password
                if (updated_password == "")
                {
                    ShowWarningFmt("login_parse: Empty password: Could not update password for user <{}>.", username);
                    sendLoginResult(login_result::LOGIN_ERROR_CHANGE_PASSWORD, 1);
                    return;
                }

                db::preparedStmt("UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = ?", accid);

                const auto rset2 = db::preparedStmt("UPDATE accounts SET accounts.password = ? WHERE accounts.id = ?",
                                                    BCrypt::generateHash(updated_password), accid);
                if (!rset2)
                {
                    ShowWarningFmt("login_parse: Error trying to update password in database for user <{}>.", username);
                    sendLoginResult(login_result::LOGIN_ERROR_CHANGE_PASSWORD, 1);
                    return;
                }

                json loginErrorChangePasswordReply;
                loginErrorChangePasswordReply["result"]       = login_result::LOGIN_SUCCESS_CHANGE_PASSWORD;
                loginErrorChangePasswordReply["account_id"]   = 0;
                loginErrorChangePasswordReply["session_hash"] = "";

                sendJsonAsBuffer(loginErrorChangePasswordReply);

                ShowInfoFmt("login_parse: password updated for account {} successfully.", accid);
                return;
            }
            break;
        }
        case login_cmd::LOGIN_CREATE_TOTP:
        {
            // Look up and validate account password
            if (!validatePassword(username, password))
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
                return;
            }

            const auto serverName = settings::get<std::string>("main.SERVER_NAME");
            const auto secret     = otpHelpers::createAccountSecret(username, "TOTP");

            if (!secret.empty())
            {
                const std::string uri = fmt::format("otpauth://totp/{}:{}?secret={}&issuer={}&algorithm={}&digits=6&period=30", serverName, username, secret, serverName, "SHA1");

                json sendTOTP;
                sendTOTP["result"]   = login_result::LOGIN_SUCCESS_CREATE_TOTP;
                sendTOTP["TOTP_uri"] = uri;

                sendJsonAsBuffer(sendTOTP);
            }
            else
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
            }
            break;
        }
        case login_cmd::LOGIN_REMOVE_TOTP:
        {
            // Look up and validate account password
            if (!validatePassword(username, password))
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
                return;
            }

            const auto secret       = otpHelpers::getAccountSecret(username, "TOTP");
            const auto recoveryCode = otpHelpers::getAccountRecoveryCode(username, "TOTP");

            // Perform case-insensitive comparison on the recovery code vs input otp
            // use c_str() because that guarantees both have a null terminator (and thus are the same length)
            if (otpHelpers::validateTOTP(otp, secret) || strcmpi(otp.c_str(), recoveryCode.c_str()) == 0)
            {
                // validated
                const auto rset = db::preparedStmt("DELETE FROM accounts_totp WHERE accounts_totp.accid = ? LIMIT 1", loginHelpers::getAccountId(username));

                json sendSuccess;
                sendSuccess["result"] = login_result::LOGIN_SUCCESS_REMOVE_TOTP;

                sendJsonAsBuffer(sendSuccess);
            }
            else
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
            }
            break;
        }
        case login_cmd::LOGIN_REGENERATE_RECOVERY:
        {
            // Look up and validate account password
            if (!validatePassword(username, password))
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
                return;
            }

            const auto secret       = otpHelpers::getAccountSecret(username, "TOTP");
            const auto recoveryCode = otpHelpers::getAccountRecoveryCode(username, "TOTP");

            // Perform case-insensitive comparison on the recovery code vs input otp
            // use c_str() because that guarantees both have a null terminator (and thus are the same length)
            if (otpHelpers::validateTOTP(otp, secret) || strcmpi(otp.c_str(), recoveryCode.c_str()) == 0)
            {
                const auto newRecoveryCode = otpHelpers::regenerateAccountRecoveryCode(username, "TOTP");

                json sendTOTP;

                sendTOTP["result"]        = login_result::LOGIN_SUCCESS_VERIFY_TOTP;
                sendTOTP["recovery_code"] = newRecoveryCode;
                sendJsonAsBuffer(sendTOTP);
            }
            else
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
            }
            break;
        }
        case login_cmd::LOGIN_VERIFY_TOTP:
        {
            // Look up and validate account password
            if (!validatePassword(username, password))
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
                return;
            }

            const auto secret = otpHelpers::getAccountSecret(username, "TOTP");

            if (otpHelpers::validateTOTP(otp, secret))
            {
                // validated
                const auto rset = db::preparedStmt("UPDATE accounts_totp SET validated = TRUE WHERE accid = ? LIMIT 1", loginHelpers::getAccountId(username));

                json sendTOTP;
                sendTOTP["result"]        = login_result::LOGIN_SUCCESS_VERIFY_TOTP;
                sendTOTP["recovery_code"] = otpHelpers::getAccountRecoveryCode(username, "TOTP");
                sendJsonAsBuffer(sendTOTP);
            }
            else
            {
                sendJsonOnlyErrorMessage("Failed to validate credentials");
            }

            break;
        }
        default:
        {
            ShowErrorFmt("Unhandled auth code: {} from {}", code, ipAddress);
        }
        break;
    }
}

void auth_session::do_write(std::size_t length)
{
    // clang-format off
    asio::async_write(socket_, asio::buffer(buffer_.data(), length),
    [this, self = shared_from_this()](std::error_code ec, std::size_t /*length*/)
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

bool auth_session::validatePassword(std::string username, std::string password)
{
    // clang-format off
    auto passHash = [&]() -> std::string
    {
        const auto rset = db::preparedStmt("SELECT accounts.password FROM accounts WHERE accounts.login = ?", username);
        if (rset && rset->rowsCount() != 0 && rset->next())
        {
            return rset->get<std::string>("password");
        }
        return "";
    }();
    // clang-format on

    if (isBcryptHash(passHash))
    {
        // It's a BCrypt hash, so we can validate it.
        if (!BCrypt::validatePassword(password, passHash))
        {
            return false;
        }
    }
    else
    {
        // It's not a BCrypt hash, so we need to use Maria's PASSWORD() to check if the password is actually correct,
        // and then update the password to a BCrypt hash.
        const auto rset = db::preparedStmt("SELECT PASSWORD(?)", password);
        if (rset && rset->rowsCount() != 0 && rset->next())
        {
            if (rset->get<std::string>(0) != passHash)
            {
                return false;
            }

            passHash = BCrypt::generateHash(password);
            db::preparedStmt("UPDATE accounts SET accounts.password = ? WHERE accounts.login = ?", passHash, username);
            if (!BCrypt::validatePassword(password, passHash))
            {
                return false;
            }
        }
    }
    return true;
}
