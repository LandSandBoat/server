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

#include "watchdog.h"

Watchdog::Watchdog(duration timeout, std::function<void()> callback)
: m_timeout(timeout)
, m_callback(callback)
, m_lastUpdate(server_clock::now())
, m_running(true)
{
    m_watchdog = nonstd::jthread(&Watchdog::_innerFunc, this);
}

Watchdog::~Watchdog()
{
    if (m_running)
    {
        std::unique_lock<std::mutex> lock(m_bottleneck);

        m_running = false;
        m_stopCondition.notify_all();
    }
}

void Watchdog::update()
{
    std::unique_lock<std::mutex> lock(m_bottleneck);

    m_lastUpdate = server_clock::now();
}

void Watchdog::_innerFunc()
{
    std::unique_lock<std::mutex> lock(m_bottleneck);

    while ((server_clock::now() - m_lastUpdate) < m_timeout)
    {
        m_stopCondition.wait_for(lock, m_timeout);
    }

    if (m_running)
    {
        m_running = false;
        m_callback();
    }
}
