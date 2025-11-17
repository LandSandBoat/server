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

#include <cctype>
#include <chrono>
#include <openssl/hmac.h>
#include <openssl/sha.h>
#include <stdexcept>
#include <string>
#include <vector>

#include "common/xirand.h"
#include "login_helpers.h"

namespace otpHelpers
{

std::vector<uint8_t> base32Decode(const std::string& base32)
{
    static const std::array<int8_t, 256> lookup = []
    {
        std::array<int8_t, 256> table{};
        table.fill(-1);
        for (char c = 'A'; c <= 'Z'; ++c)
        {
            table[(unsigned char)c] = c - 'A';
        }

        for (char c = '2'; c <= '7'; ++c)
        {
            table[(unsigned char)c] = 26 + (c - '2');
        }

        return table;
    }();

    std::vector<uint8_t> bytes;
    int                  buffer   = 0;
    int                  bitsLeft = 0;

    for (char ch : base32)
    {
        if (ch == '=' || ch == ' ' || ch == '-' || ch == '_')
        {
            continue;
        }

        ch         = std::toupper(static_cast<unsigned char>(ch));
        int8_t val = lookup[(unsigned char)ch];
        if (val == -1)
        {
            throw std::runtime_error("Invalid Base32 character");
        }

        buffer <<= 5;
        buffer |= val;
        bitsLeft += 5;
        if (bitsLeft >= 8)
        {
            bitsLeft -= 8;
            bytes.push_back((buffer >> bitsLeft) & 0xFF);
        }
    }

    return bytes;
}

std::string generateTOTP(const std::string& base32Secret, uint64_t epochSeconds, int digits = 6, int period = 30)
{
    std::vector<uint8_t> key     = base32Decode(base32Secret);
    uint64_t             counter = epochSeconds / period;

    uint8_t counterBytes[8];
    for (int i = 7; i >= 0; --i)
    {
        counterBytes[i] = counter & 0xFF;
        counter >>= 8;
    }

    unsigned char hash[SHA_DIGEST_LENGTH];
    HMAC(EVP_sha1(), key.data(), (int)key.size(), counterBytes, 8, hash, nullptr);

    int      offset     = hash[SHA_DIGEST_LENGTH - 1] & 0x0F;
    uint32_t binaryCode = (hash[offset] & 0x7F) << 24 |
                          (hash[offset + 1] & 0xFF) << 16 |
                          (hash[offset + 2] & 0xFF) << 8 |
                          (hash[offset + 3] & 0xFF);

    uint32_t otp = binaryCode % 1000000;

    char result[10];
    snprintf(result, sizeof(result), "%0*u", digits, otp);
    return std::string(result);
}

// Base32 used for OTP standard. Doesn't use repeat alike characters such as both O and 0, and opts to use letters over similar numbers.
// clang-format off
static const char BASE32_CHARS[32] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5',
    '6', '7'
};
// clang-format on

inline uint64_t getCurrentTime()
{
    auto now = std::chrono::system_clock::now();
    auto dur = now.time_since_epoch();

    return std::chrono::duration_cast<std::chrono::seconds>(dur).count();
}

inline bool validateTOTP(const std::string& totpCode, const std::string& secret)
{
    bool valid = false;

    auto res = generateTOTP(secret, getCurrentTime());

    if (totpCode == res)
    {
        valid = true;
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
