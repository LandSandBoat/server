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

#include "common/logging.h"

#include "map/zone.h"

#include <mutex>

#include <httplib.h>
#include <task_system.hpp>

class HTTPServer
{
public:
    HTTPServer();
    ~HTTPServer();

    void LockingUpdate();

private:
    httplib::Server         m_httpServer;
    std::mutex              m_updateBottleneck;
    std::atomic<time_point> m_lastUpdate;

    std::unique_ptr<ts::task_system> ts;

    struct APIDataCache
    {
        uint32                                 activeSessionCount;
        std::array<uint32, ZONEID::MAX_ZONEID> zonePlayerCounts;
    } m_apiDataCache{};
};
