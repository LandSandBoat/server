/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <common/cbasetypes.h>
#include <common/timer.h>
#include <common/types/maybe.h>
#include <common/vana_time.h>

#include <common/types/flat_hash_map.h>

#include "map_constants.h"

#include <map>
#include <memory>

#include "data/enums/weather.h"

class CMobEntity;
class CZone;
class SpawnSlot;

struct PendingSlotRespawn
{
    timer::time_point respawnAt;
    Maybe<uint32>     specificMobId;
};

class SpawnHandler
{
public:
    explicit SpawnHandler(CZone* PZone);
    ~SpawnHandler(); // out-of-line: spawnSlots_ holds unique_ptr to (here) incomplete SpawnSlot

    // Get the spawn slot for slotId, creating it if it doesn't exist yet.
    auto getOrCreateSpawnSlot(uint32_t slotId) -> SpawnSlot*;

    // Get the spawn slot for slotId, or nullptr if none exists.
    auto getSpawnSlot(uint32_t slotId) const -> SpawnSlot*;

    void Tick(timer::time_point now);
    void registerForRespawn(CMobEntity* PMob, Maybe<timer::duration> respawnTime = std::nullopt);
    void unregister(CMobEntity* PMob);
    auto isRegistered(CMobEntity* PMob) const -> bool;
    auto getRemainingRespawnTime(CMobEntity* PMob) const -> Maybe<timer::duration>;
    void onGameHour(uint32 hour) const;
    void onWeatherChange(xi::Weather weather) const;
    auto canSpawnNow(const CMobEntity* PMob) const -> bool;

private:
    CZone* zone_;

    timer::duration                                spawnWindow_{ kSpawnHandlerWindow };
    FlatHashMap<uint32, timer::time_point>         pendingRespawns_;     // Non-slotted mobs: mobId -> respawnAt timestamp
    FlatHashMap<SpawnSlot*, PendingSlotRespawn>    pendingSlotRespawns_; // Slotted mobs: slot pointer -> respawn info
    std::map<uint32_t, std::unique_ptr<SpawnSlot>> spawnSlots_;          // Owns this zone's spawn slots, keyed by slot id
};
