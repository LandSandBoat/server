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

#include "world_application.h"

#include "common/application.h"
#include "common/logging.h"

#include "ipc_server.h"
#include "world_engine.h"

namespace
{

auto appConfig() -> ApplicationConfig
{
    return ApplicationConfig{
        .serverName = "world",
        .arguments  = {},
    };
}

} // namespace

WorldApplication::WorldApplication(const int argc, char** argv)
: Application(appConfig(), argc, argv)
{
}

WorldApplication::~WorldApplication() = default;

auto WorldApplication::createEngine() -> std::unique_ptr<Engine>
{
    return std::make_unique<WorldEngine>(ioContext());
}

void WorldApplication::requestExit()
{
    Application::requestExit();
    io_context_.stop();
}
