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

#include "common/logging.h"
#include "common/settings.h"

#include <asio/ssl.hpp>
#include <chrono>
#include <filesystem>
#include <stdexcept>
#include <string>
#include <thread>

namespace certificateHelpers
{

// creates the key and cert on first start; one pair serves every TLS listener (xi_connect auth/data/view, xi_profile)
inline void generateSelfSignedCert()
{
    const auto keyFile  = settings::get<std::string>("network.TLS_KEY");
    const auto certFile = settings::get<std::string>("network.TLS_CERT");

    // the key is created exclusively so concurrently starting servers generate a single pair
    FILE* keyHandle = nullptr;
    if (!std::filesystem::exists(keyFile) && !std::filesystem::exists(certFile))
    {
        keyHandle = fopen(keyFile.c_str(), "wx");
    }

    if (keyHandle)
    {
        ShowInfo("Generating self-signed certificate");

        EVP_PKEY* pkey = EVP_RSA_gen(4096);
        if (pkey == nullptr)
        {
            ShowError("Failed to generate private key!");
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

        X509_NAME* subject = X509_get_subject_name(x509);

        std::string   authIpAddr           = settings::get<std::string>("network.LOGIN_AUTH_IP");
        unsigned char commonNameIpAddr[17] = {}; // size of "255.255.255.255\0"

        authIpAddr.copy(reinterpret_cast<char*>(commonNameIpAddr), sizeof(commonNameIpAddr) - 1);

        X509_NAME_add_entry_by_txt(subject, "O", MBSTRING_ASC, reinterpret_cast<const unsigned char*>("LSB self-signed certificate"), -1, -1, 0);
        X509_NAME_add_entry_by_txt(subject, "CN", MBSTRING_ASC, commonNameIpAddr, -1, -1, 0);

        X509_set_issuer_name(x509, subject);

        if (!X509_sign(x509, pkey, EVP_sha384()))
        {
            ShowError("Failed to sign X509 cert!");
        }

        if (!PEM_write_PrivateKey(keyHandle, pkey, nullptr, nullptr, 0, nullptr, nullptr))
        {
            ShowError(fmt::format("Failed to write {}!", keyFile));
        }
        fclose(keyHandle);

        // the cert appears in one step, so its presence means the pair is complete
        const auto certTemp   = certFile + ".tmp";
        FILE*      fileHandle = fopen(certTemp.c_str(), "wb");
        if (fileHandle)
        {
            if (!PEM_write_X509(fileHandle, x509))
            {
                ShowError(fmt::format("Failed to write {}!", certFile));
            }
            fclose(fileHandle);

            std::error_code ec;
            std::filesystem::rename(certTemp, certFile, ec);
            if (ec)
            {
                ShowError(fmt::format("Failed to write {}! ({})", certFile, ec.message()));
            }
        }
        EVP_PKEY_free(pkey);
        X509_free(x509);
    }

    // another server may still be generating the pair
    for (int attempt = 0; attempt < 300 && std::filesystem::exists(keyFile) && !std::filesystem::exists(certFile); ++attempt)
    {
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }

    if (std::filesystem::exists(keyFile))
    {
        FILE* fileHandle = fopen(keyFile.c_str(), "r");
        if (fileHandle)
        {
            EVP_PKEY* pkey = PEM_read_PrivateKey(fileHandle, nullptr, nullptr, nullptr);
            if (pkey)
            {
                ShowInfo(fmt::format("Found existing {}", keyFile));
            }

            EVP_PKEY_free(pkey);
            fclose(fileHandle);
        }
    }

    if (std::filesystem::exists(certFile))
    {
        FILE* fileHandle = fopen(certFile.c_str(), "r");
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
                ShowInfo(fmt::format("Found existing {}: {}", certFile, asStringFromUntrustedSource(cn, sizeof(cn))));

                // if current time not within the bounds of valid date, note it's expired
                if (X509_cmp_time(X509_get_notAfter(cert), nullptr) != 1 || X509_cmp_time(X509_get_notBefore(cert), nullptr) != -1)
                {
                    ShowWarning(fmt::format("Existing {} is not valid for the current time. Please regenerate or obtain a new certificate.", certFile));
                }
            }

            X509_free(cert);
            fclose(fileHandle);
        }
    }
}

// TLS 1.3 server context loaded with the shared key and cert
inline auto serverContext() -> asio::ssl::context
{
    const auto keyFile  = settings::get<std::string>("network.TLS_KEY");
    const auto certFile = settings::get<std::string>("network.TLS_CERT");

    asio::ssl::context context(asio::ssl::context::tlsv13_server);
    context.set_options(asio::ssl::context::default_workarounds);

    asio::error_code ec;
    context.use_certificate_chain_file(certFile, ec);
    if (!ec)
    {
        context.use_private_key_file(keyFile, asio::ssl::context::file_format::pem, ec);
    }

    if (ec)
    {
        throw std::runtime_error(fmt::format("Cannot load {} and {} ({})", certFile, keyFile, ec.message()));
    }

    return context;
}

} // namespace certificateHelpers
