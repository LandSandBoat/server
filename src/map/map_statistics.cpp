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

#include "map_statistics.h"

#include "common/tracy.h"

#include "lua/luautils.h"

#include <magic_enum/magic_enum.hpp>

MapStatistics::MapStatistics()
{
    reset();
}

auto MapStatistics::toString(Key key)
{
    switch (key)
    {
        case Key::TotalPacketsToSendPerTick:
            return "Total Packets To Send Per Tick";
        case Key::TotalPacketsSentPerTick:
            return "Total Packets Sent Per Tick";
        case Key::TotalPacketsDelayedPerTick:
            return "Total Packets Delayed Per Tick";
        case Key::TasksTickTime:
            return "Tasks Tick Time (ms)";
        case Key::NetworkTickTime:
            return "Network Tick Time (ms)";
        case Key::TotalTickTime:
            return "Total Tick Time (ms)";
        case Key::TickDiffTime:
            return "Tick Diff/Sleep Time (ms)";
        case Key::ActiveZones:
            return "Active Zones (Process)";
        case Key::ConnectedPlayers:
            return "Connected Players (Process)";
        case Key::ActiveMobs:
            return "Active Mobs (Process)";
        case Key::TaskManagerTasks:
            return "Task Manager Tasks";
        case Key::DynamicTargIdUsagePercent:
            return "Dynamic TargID Usage (%)";
        default:
            return "Unknown";
    }
}

void MapStatistics::set(Key key, int64 value)
{
    statistics_[key] = value;
}

auto MapStatistics::get(Key key) const -> int64
{
    if (statistics_.find(key) == statistics_.end())
    {
        return 0;
    }

    return statistics_.at(key);
}

void MapStatistics::increment(Key key, int64 amount)
{
    statistics_[key] += amount;
}

void MapStatistics::decrement(Key key, int64 amount)
{
    statistics_[key] -= amount;
}

void MapStatistics::print()
{
    TracyZoneScoped;

    fmt::print("=== Map Statistics ===\n\n");

    for (const auto& [key, value] : statistics_)
    {
        fmt::print("{}: {}\n", toString(key), value);
    }

    reset();
}

void MapStatistics::flush()
{
    TracyZoneScoped;
    TracyReportLuaMemory(lua.lua_state());

    for (const auto& [key, value] : statistics_)
    {
        TracyReportGraphNumber(toString(key), value);
    }

    reset();
}

void MapStatistics::reset()
{
    TracyZoneScoped;

    for (const auto& key : magic_enum::enum_values<Key>())
    {
        statistics_[key] = 0;
    }
}
