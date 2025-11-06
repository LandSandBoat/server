/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#pragma once

#include "common/xirand.h"
#include "login_helpers.h"

// This ugly nonsense is because winerror.h defines NO_ERROR and an enum definition inside cotp uses NO_ERROR,
// if NO_ERROR is defined as 0 (from winerror.h) then the compiler thinks you're trying to define `0` as an enum, which you can't.
#ifdef NO_ERROR

#define TEMP_DEFINITION_HACK NO_ERROR
#undef NO_ERROR
#include "cotp.h"
#define NO_ERROR TEMP_DEFINITION_HACK
#undef TEMP_DEFINITION_HACK

#else

#include "cotp.h"

#endif

namespace otpHelpers
{
    // Base32 used for OTP standard. Doesn't use repeat alike characters such as both O and 0, and opts to use letters over similar numbers.
    static const char BASE32_CHARS[32] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
        'U', 'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5',
        '6', '7'
    };

    inline uint64_t getCurrentTime()
    {
        auto now = std::chrono::system_clock::now();
        auto dur = now.time_since_epoch();

        return std::chrono::duration_cast<std::chrono::seconds>(dur).count();
    }

    inline bool validateTOTP(const std::string& totpCode, const std::string& secret)
    {
        bool         valid   = false;
        cotp_error_t cotpErr = {};

        auto res = get_totp_at(secret.c_str(), getCurrentTime(), 6, 30, SHA1, &cotpErr);

        // TODO: do we care about errors?
        if (res)
        {
            if (strcmpi(totpCode.c_str(), res) == 0) // Need to use c_str for null terminator
            {
                valid = true;
            }
            destroy(res); // per docs, this string needs to be freed upon non-null return
        }

        return valid;
    }

    inline std::string getNewBase32Secret()
    {
        constexpr size_t base32Len = 32; // must be % 8 == 0

        char newSecret[base32Len + 1] = {};

        for (size_t i = 0; i < base32Len; i++)
        {
            newSecret[i] = BASE32_CHARS[xirand::GetRandomNumber<uint64_t>(0, std::numeric_limits<uint64_t>::max()) % 32];
        }

        return newSecret;
    }

    inline bool doesAccountNeedOTP(const std::string& account, const std::string& secretType)
    {
        if (secretType == "TOTP")
        {
            const auto accid = loginHelpers::getAccountId(account);
            if (accid != 0)
            {
                const auto rset = db::preparedStmt("SELECT validated FROM accounts_totp where accid = ?", accid);
                if (!rset)
                {
                    return false;
                }

                bool hasExistingOTP = false;

                if (rset->rowsCount() != 0 && rset->next())
                {
                    hasExistingOTP = rset->get<bool>("validated");
                }

                return hasExistingOTP;
            }
        }
        return false;
    }

    inline std::string createAccountSecret(const std::string& account, const std::string& secretType)
    {
        if (secretType == "TOTP")
        {
            const auto hasExistingOTP = otpHelpers::doesAccountNeedOTP(account, "TOTP");

            if (!hasExistingOTP)
            {
                uint32 accid = loginHelpers::getAccountId(account);
                if (accid == 0)
                {
                    return "";
                }

                const auto newSecret       = getNewBase32Secret();
                const auto newRecoveryCode = getNewBase32Secret();

                const auto rset = db::preparedStmt("INSERT INTO accounts_totp(accid, secret, recovery_code, validated) VALUES(?, ?, ?, 0) ON DUPLICATE KEY UPDATE secret = values(secret), recovery_code = values(recovery_code)", accid, newSecret, newRecoveryCode);
                if (rset)
                {
                    return newSecret;
                }
            }
        }
        return "";
    }

    inline std::string regenerateAccountRecoveryCode(const std::string& account, const std::string& secretType)
    {
        if (secretType == "TOTP")
        {
            const auto hasExistingOTP = otpHelpers::doesAccountNeedOTP(account, "TOTP");

            if (hasExistingOTP)
            {
                uint32 accid = loginHelpers::getAccountId(account);
                if (accid == 0)
                {
                    return "";
                }

                std::string newRecoveryCode = getNewBase32Secret();
                const auto  rset            = db::preparedStmt("UPDATE accounts_totp SET accounts_totp.recovery_code = ? WHERE accounts_totp.accid = ?", newRecoveryCode, accid);
                if (rset)
                {
                    return newRecoveryCode;
                }
            }
        }
        return "";
    }

    inline std::string getAccountSecret(const std::string& account, const std::string& secretType)
    {
        if (secretType == "TOTP")
        {
            const auto accid = loginHelpers::getAccountId(account);
            if (accid != 0)
            {
                const auto rset = db::preparedStmt("SELECT secret FROM accounts_totp where accid = ? LIMIT 1", accid);
                if (rset && rset->next())
                {
                    return rset->get<std::string>("secret");
                }
            }
        }
        return "";
    }

    inline std::string getAccountRecoveryCode(const std::string& account, const std::string& secretType)
    {
        if (secretType == "TOTP")
        {
            const auto accid = loginHelpers::getAccountId(account);
            if (accid != 0)
            {
                const auto rset = db::preparedStmt("SELECT recovery_code FROM accounts_totp where accid = ? LIMIT 1", accid);
                if (rset && rset->next())
                {
                    return rset->get<std::string>("recovery_code");
                }
            }
        }
        return "";
    }

} // namespace otpHelpers
