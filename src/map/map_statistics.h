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

#include "common/cbasetypes.h"

class MapStatistics
{
public:
    enum class Key
    {
        TotalPacketsToSendPerTick,
        TotalPacketsSentPerTick,
        TotalPacketsDelayedPerTick,
        TasksTickTime,
        NetworkTickTime,
        TotalTickTime,
        TickDiffTime,
        ActiveZones,
        ConnectedPlayers,
        ActiveMobs,
        TaskManagerTasks,
        DynamicTargIdUsagePercent,
    };

    MapStatistics();

    static auto toString(Key key);

    void set(Key key, int64 value);
    auto get(Key key) const -> int64;

    void increment(Key key, int64 amount = 1);
    void decrement(Key key, int64 amount = 1);

    void print();
    void flush();

private:
    void reset();

    std::unordered_map<Key, int64> statistics_;
};
