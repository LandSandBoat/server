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

#include "map_application.h"

#include "common/arguments.h"
#include "common/console_service.h"
#include "common/utils.h"
#include "map_engine.h"
#include "map_networking.h"
#include "map_socket.h"

#ifdef _WIN32
#include <io.h>
#endif

namespace
{

auto appConfig() -> ApplicationConfig
{
    const std::vector arguments = {
        ArgumentDefinition{
            .name        = "--ip",
            .description = "Specify the IP address to bind to",
        },
        ArgumentDefinition{
            .name        = "--port",
            .description = "Specify the port to bind to",
        },
        ArgumentDefinition{
            .name        = "--lazy",
            .description = "Load zones on demand. For development only.",
            .type        = ArgumentType::Flag,
        },
    };

    return ApplicationConfig{
        .serverName = "map",
        .arguments  = arguments,
    };
}

} // namespace

MapApplication::MapApplication(const int argc, char** argv)
: Application(appConfig(), argc, argv)
{
    auto ip   = 0;
    auto port = 0;

    if (const auto maybeIP = args().present("--ip"))
    {
        ip = str2ip(*maybeIP);
    }

    if (const auto maybePort = args().present("--port"))
    {
        port = std::stoi(*maybePort);
    }

    engineConfig_.lazyZones = args().get<bool>("--lazy");
    engineConfig_.inCI      = Application::isRunningInCI();
    engineConfig_.ipp       = IPP(ip, port);
}

MapApplication::~MapApplication()
{
}

auto MapApplication::createEngine() -> std::unique_ptr<Engine>
{
    return std::make_unique<MapEngine>(ioContext(), engineConfig_);
}

void MapApplication::registerCommands(ConsoleService& console)
{
    auto* mapEngine = static_cast<MapEngine*>(engine_.get());

    console.registerCommand("gm", "Change a character's GM level", std::bind(&MapEngine::onGM, mapEngine, std::placeholders::_1));
    console.registerCommand("reload_recipes", "Reload crafting recipes", std::bind(&MapEngine::onReloadRecipes, mapEngine, std::placeholders::_1));
    console.registerCommand("stats", "Print runtime stats", std::bind(&MapEngine::onStats, mapEngine, std::placeholders::_1));
    console.registerCommand("backtrace", "Print backtrace", std::bind(&MapEngine::onBacktrace, mapEngine, std::placeholders::_1));
}

void MapApplication::run()
{
    engine_ = createEngine();

    if (engine_)
    {
        engine_->onInitialize();

        registerCommands(console());
    }

    markLoaded();
    auto* mapEngine = dynamic_cast<MapEngine*>(engine_.get());

    while (Application::isRunning())
    {
        mapEngine->gameLoop();
    }

    // MapEngine destructor must occur before Application destructor
    engine_.reset();
    io_context_.stop();

    const auto taskManager = CTaskManager::getInstance();
    while (!taskManager->getTaskList().empty())
    {
        taskManager->getTaskList().pop();
    }
}
