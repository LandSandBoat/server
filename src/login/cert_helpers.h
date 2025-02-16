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

#pragma once

#include <asio/ssl.hpp>

namespace certificateHelpers
{
    inline void generateSelfSignedCert()
    {
        if (std::filesystem::exists("login.key"))
        {
            FILE* fileHandle = fopen("login.key", "r");
            if (fileHandle)
            {
                EVP_PKEY* pkey = PEM_read_PrivateKey(fileHandle, nullptr, nullptr, nullptr);
                if (pkey)
                {
                    ShowInfo(fmt::format("Found existing login.key"));
                }
            }
            fclose(fileHandle);
        }

        if (std::filesystem::exists("login.cert"))
        {
            FILE* fileHandle = fopen("login.cert", "r");
            if (fileHandle)
            {
                X509* cert = PEM_read_X509(fileHandle, nullptr, nullptr, nullptr);
                if (cert)
                {
                    char cn[2048] = {};
                    int  size     = sizeof(cn);

                    X509_NAME_oneline(X509_get_subject_name(cert), cn, size);
                    X509_NAME_oneline(X509_get_issuer_name(cert), cn, size);

                    // This is internal, so we can trust it.
                    ShowInfo(fmt::format("Found existing login.cert: {}", asStringFromUntrustedSource(cn)));

                    // if current time not within the bounds of valid date, note it's expired
                    if (X509_cmp_time(X509_get_notAfter(cert), nullptr) != 1 || X509_cmp_time(X509_get_notBefore(cert), nullptr) != -1)
                    {
                        ShowWarning("Existing login.cert is not valid for the current time. Please regenerate or obtain a new certificate.");
                    }
                }

                fclose(fileHandle);
            }
        }

        if (!std::filesystem::exists("login.key") && !std::filesystem::exists("login.cert"))
        {
            ShowInfo("Generating self-signed certificate");

            EVP_PKEY* pkey = EVP_RSA_gen(4096);

            if (pkey == nullptr)
            {
                ShowError("Failed to generate RSA private key!");
            }

            X509* x509 = X509_new();

            if (x509 == nullptr)
            {
                ShowError("Failed to generate allocate X509 cert!");
            }

            ASN1_INTEGER_set(X509_get_serialNumber(x509), 1);         // cert #1 for self-signed
            X509_gmtime_adj(X509_get_notBefore(x509), 0);             // valid from now
            X509_gmtime_adj(X509_get_notAfter(x509), 31536000L * 20); // expires 20 years from now

            if (!X509_set_pubkey(x509, pkey))
            {
                ShowError("Failed to assign private key to X509 cert!");
            }

            X509_NAME* name;
            name = X509_get_subject_name(x509);

            std::string   authIpAddr           = settings::get<std::string>("network.LOGIN_AUTH_IP");
            unsigned char commonNameIpAddr[17] = {}; // size of "255.255.255.255\0"

            std::memcpy(commonNameIpAddr, authIpAddr.c_str(), authIpAddr.length());

            // TODO: do we need to set/support country code, among others?
            /* X509_NAME_add_entry_by_txt(name, "C", MBSTRING_ASC,
                                       (unsigned char*)"CA", -1, -1, 0);*/
            X509_NAME_add_entry_by_txt(name, "O", MBSTRING_ASC,
                                       (unsigned char*)"LSB self-signed certificate for login server", -1, -1, 0);
            X509_NAME_add_entry_by_txt(name, "CN", MBSTRING_ASC,
                                       commonNameIpAddr, -1, -1, 0);

            X509_set_issuer_name(x509, name);

            if (!X509_sign(x509, pkey, EVP_sha384()))
            {
                ShowError("Failed to sign X509 cert!");
            }

            FILE* fileHandle = fopen("login.key", "wb");
            if (fileHandle)
            {
                if (!PEM_write_PrivateKey(fileHandle, pkey, nullptr, nullptr, 0, 0, nullptr))
                {
                    ShowError("Failed to write login.key!");
                }
                fclose(fileHandle);
            }

            fileHandle = fopen("login.cert", "wb");
            if (fileHandle)
            {
                if (!PEM_write_X509(fileHandle, x509))
                {
                    ShowError("Failed to write login.cert!");
                }
                fclose(fileHandle);
            }
            EVP_PKEY_free(pkey);
        }
    }
} // namespace certificateHelpers
