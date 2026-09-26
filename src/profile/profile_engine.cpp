/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "profile_engine.h"

#include "common/logging.h"

#include <stdexcept>

ProfileEngine::ProfileEngine()
: tls_(asio::ssl::context::tlsv13_server)
{
    auto ec = asio::error_code{};
    tls_.set_options(asio::ssl::context::default_workarounds);
    tls_.use_certificate_chain_file("profile.cert", ec);
    if (!ec)
    {
        tls_.use_private_key_file("profile.key", asio::ssl::context::file_format::pem, ec);
    }

    if (ec)
    {
        throw std::runtime_error(fmt::format("Cannot load profile.cert and profile.key ({})", ec.message()));
    }
}

ProfileEngine::~ProfileEngine() = default;
