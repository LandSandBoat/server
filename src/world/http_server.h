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
#include "common/synchronized.h"
#include "common/timer.h"

#include "map/zone.h"

#include <mutex>

#include <httplib.h>

class HTTPServer
{
public:
    HTTPServer();
    ~HTTPServer();

    void LockingUpdate();

private:
    httplib::Server                m_httpServer;
    std::atomic<timer::time_point> m_lastUpdate;

    struct APIDataCache
    {
        uint32                                 activeSessionCount;
        uint32                                 activeUniqueIPCount;
        std::array<uint32, ZONEID::MAX_ZONEID> zonePlayerCounts;
    };

    SynchronizedShared<APIDataCache> m_apiDataCache;
};
