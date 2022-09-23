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

#pragma once

#include "common/application.h"
#include "common/console_service.h"
#include "common/logging.h"

class WorldServer final : public Application
{
public:
    WorldServer(std::unique_ptr<argparse::ArgumentParser>&& pArgParser)
    : Application("world", std::move(pArgParser))
    {
        // World server should _mostly_ be comprised of ZMQ handlers and timed tasks.

        gConsoleService->RegisterCommand("stats", "Print server runtime statistics", [&]()
        {
            fmt::print("TODO: Some stats!\n");
        });
    }

    ~WorldServer() override
    {
        // Everything should be handled with RAII
    }

    void Tick() override
    {
        Application::Tick();

        // World Server specific things
    }

private:
    // World server doesn't need external-facing sockets
};
