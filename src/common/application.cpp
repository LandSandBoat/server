/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "application.h"
#include "settings_manager.h"
#include "debug.h"

#include <iostream>
#include <string>

Application::Application(std::string const& serverName, std::unique_ptr<argparse::ArgumentParser>&& pArgParser)
: m_ServerName(serverName)
, gArgParser(std::move(pArgParser))
, m_IsRunning(true)
{
    logging::InitializeLog(serverName, fmt::format("log/{}-server.log", serverName), false);

    debug::init();

    gConsoleService = std::make_unique<ConsoleService>();
}

bool Application::IsRunning()
{
    return m_IsRunning;
}

void Application::Tick()
{
    // gZMQ->Tick();
    // gSQL->Tick();
    // gDebug->Tick();
    // gTaskManager->Tick();
}
