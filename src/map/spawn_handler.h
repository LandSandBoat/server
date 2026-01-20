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

#include "common/cbasetypes.h"
#include "common/timer.h"
#include "common/vana_time.h"
#include "map_constants.h"

#include <optional>
#include <unordered_map>

enum class Weather : uint16_t;

class CMobEntity;
class CZone;
class SpawnSlot;

struct PendingSlotRespawn
{
    timer::time_point     respawnAt;
    std::optional<uint32> specificMobId;
};

class SpawnHandler
{
public:
    explicit SpawnHandler(CZone* PZone);

    void Tick(timer::time_point now);
    void registerForRespawn(CMobEntity* PMob, std::optional<timer::duration> respawnTime = std::nullopt);
    auto isRegistered(CMobEntity* PMob) const -> bool;
    void onTOTDChange(vanadiel_time::TOTD totd) const;
    void onWeatherChange(Weather weather) const;
    auto canSpawnNow(const CMobEntity* PMob) const -> bool;

private:
    CZone* zone_;

    timer::duration                                    spawnWindow_{ kSpawnHandlerWindow };
    std::unordered_map<uint32, timer::time_point>      pendingRespawns_;     // Non-slotted mobs: mobId -> respawnAt timestamp
    std::unordered_map<SpawnSlot*, PendingSlotRespawn> pendingSlotRespawns_; // Slotted mobs: slot pointer -> respawn info
};
