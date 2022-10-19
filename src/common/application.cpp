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
#include "debug.h"
#include "logging.h"
#include "taskmgr.h"

#ifdef _WIN32
#include <windows.h>
#endif

Application::Application(std::string const& serverName, std::unique_ptr<argparse::ArgumentParser>&& pArgParser)
: m_ServerName(serverName)
, m_IsRunning(true)
, gArgParser(std::move(pArgParser))
{
#ifdef _WIN32
    SetConsoleTitleA(fmt::format("{}-server", serverName).c_str());
#endif

    logging::InitializeLog(serverName, fmt::format("log/{}-server.log", serverName), false);
    ShowInfo("Begin %s-server initialisation...", serverName);

    debug::init();

    ShowInfo("The %s-server is ready to work...", serverName);
    ShowInfo("=======================================================================");

    gConsoleService = std::make_unique<ConsoleService>();
}

bool Application::IsRunning()
{
    return m_IsRunning;
}

void Application::Tick()
{
    // Main runtime cycle
    duration next;
    while (m_IsRunning)
    {
        next = CTaskMgr::getInstance()->DoTimer(server_clock::now());
        // do_sockets(&rfd, next);
    }
}
