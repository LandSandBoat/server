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
#include <sol/forward.hpp>

class InMemorySink;
class MapServer;
class CLuaSimClient;
class CLuaBaseEntity;

enum class RegionType : uint8;

class CLuaSimulation
{
    std::vector<std::unique_ptr<CLuaSimClient>> m_clients;
    MapServer*                                  m_engine = nullptr;
    std::shared_ptr<InMemorySink>               m_sink   = nullptr;

public:
    CLuaSimulation(MapServer* _mapServer, const std::shared_ptr<InMemorySink>& _sink);

    auto createPlayerClient(const sol::object& zoneIdObj) -> std::optional<std::reference_wrapper<CLuaSimClient>>;
    void loadZones(sol::variadic_args va) const;
    void clean();

    /// Ticks all entities in the simulation, executes expired tasks.
    /// @param timeSeconds (Optional) How many seconds to advance the simulation clock.
    /// \code{.lua}
    /// sim:tick()
    /// \endcode
    /// @note Will advance time if provided.
    void tick(std::optional<uint32> timeSeconds) const;

    /// Ticks a specific entity.
    /// @param entity Entity to tick.
    /// @code{.lua}
    /// sim:tickEntity(player)
    /// @endcode
    /// @note Does not advance time, does not process expired tasks.
    void tickEntity(CLuaBaseEntity& entity) const;
    void addSeconds(uint32 seconds) const;

    void setRegionOwner(uint8 region, uint8 nation) const;

    void setSeed(uint64 seed) const;
    void seed() const;

    auto getLogs() const -> sol::table;
    void clearLogs() const;

    static void Register();
};
