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

#include "connect_application.h"

#include "cert_helpers.h"
#include "common/console_service.h"
#include "connect_engine.h"

namespace
{

auto appConfig() -> ApplicationConfig
{
    return ApplicationConfig{
        .serverName = "connect",
        .arguments  = {},
    };
}

} // namespace

ConnectApplication::ConnectApplication(const int argc, char** argv)
: Application(appConfig(), argc, argv)
{
}

ConnectApplication::~ConnectApplication() = default;

auto ConnectApplication::createEngine() -> std::unique_ptr<Engine>
{
    certificateHelpers::generateSelfSignedCert();
    return std::make_unique<ConnectEngine>(ioContext());
}

void ConnectApplication::registerCommands(ConsoleService& console)
{
    // clang-format off
    console.registerCommand("stats", "Print server runtime statistics",
    [](std::vector<std::string>& inputs)
    {
        const size_t uniqueIPs = loginHelpers::getAuthenticatedSessions().size();
        size_t uniqueAccounts  = 0;

        for (auto& ipAddrMap: loginHelpers::getAuthenticatedSessions())
        {
            uniqueAccounts += loginHelpers::getAuthenticatedSessions()[ipAddrMap.first].size();
        }

        ShowInfo("Serving %u IP addresses with %u accounts", uniqueIPs, uniqueAccounts);
    });
    // clang-format on
}

void ConnectApplication::requestExit()
{
    Application::requestExit();
    io_context_.stop();
}
