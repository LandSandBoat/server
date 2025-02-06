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

#pragma once

#include "common/application.h"

class MapServer final : public Application
{
public:
    MapServer(int argc, char** argv)
    : Application("map", argc, argv)
    , scheduler(ioContext_)
    , networkHandler(ioContext_, Application::getPort()) // Or something?
    {
    }

    void run()
    {
        // Queue the first async network receive.
        networkHandler_->queue_async_recv();

        // TODO: Make atomic, hide in Application:: functions.
        bool running = true;

        while (running)
        {
            const auto now = std::chrono::steady_clock::now();

            // Process scheduler tasks; run() returns a timeout duration.
            const auto next = scheduler.run(now);

            // Process network events for that duration.
            networkHandler->run_for(next);

            // If input is available (e.g., Enter pressed), exit.
            if (std::cin.rdbuf()->in_avail() > 0)
            {
                running = false;
            }
        }
    }

private:
    // TODO: This should be part of Application at this point.
    asio::io_context ioContext_;

    Scheduler      scheduler_;
    NetworkHandler networkHandler_;
    MapState       mapState_;
    MapSessions    mapSessions_; // Should this be in networkHandler or mapState instead?
};
