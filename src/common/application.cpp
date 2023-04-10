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
#include "lua.h"
#include "settings.h"
#include "taskmgr.h"

#ifdef _WIN32
#include <windows.h>
#endif

Application::Application(std::string serverName, int argc, char** argv)
: m_ServerName(serverName)
, m_RequestExit(false)
, gArgParser(std::make_unique<argparse::ArgumentParser>(argv[0]))
{
#ifdef _WIN32
    SetConsoleTitleA(fmt::format("{}-server", serverName).c_str());
#endif

    gArgParser->add_argument("--log")
        .default_value(fmt::format("log/{}-server.log", serverName));

    try
    {
        gArgParser->parse_args(argc, argv);
    }
    catch (const std::runtime_error& err)
    {
        std::cerr << err.what() << std::endl;
        std::cerr << *gArgParser;
        std::exit(1);
    }

    auto logName = gArgParser->get<std::string>("--log");
    logging::InitializeLog(serverName, logName, false);
    lua_init();
    settings::init();
    ShowInfo("Begin %s-server initialisation...", serverName);

    debug::init();

    ShowInfo("The %s-server is ready to work...", serverName);
    ShowInfo("=======================================================================");

    // clang-format off
    gConsoleService = std::make_unique<ConsoleService>();

    gConsoleService->RegisterCommand("exit", "Terminate the program.",
    [&](std::vector<std::string> inputs)
    {
        fmt::print("> Goodbye!\n");
        m_RequestExit = true;
    });
    // clang-format on
}

bool Application::IsRunning()
{
    return !m_RequestExit;
}

void Application::Tick()
{
    // Main runtime cycle
    duration next;
    while (!m_RequestExit)
    {
        next = CTaskMgr::getInstance()->DoTimer(server_clock::now());
        std::this_thread::sleep_for(next);
    }
}
