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

#include "spawn_handler.h"

#include "ai/ai_container.h"
#include "common/timer.h"
#include "common/vana_time.h"
#include "data/enums/weather.h"
#include "entities/mob_entity.h"
#include "lua/luautils.h"
#include "spawn_slot.h"
#include "utils/zoneutils.h"
#include "zone.h"

namespace
{

auto hourInWindow(const uint32 hour, const uint8 spawn, const uint8 despawn) -> bool
{
    if (spawn <= despawn)
    {
        return hour >= spawn && hour < despawn;
    }

    return hour >= spawn || hour < despawn;
}

// Spawn window for a mob, or nullopt if unrestricted. Per-mob window wins over the SPAWNTYPE flags.
auto spawnWindowOf(const CMobEntity* PMob) -> Maybe<SpawnWindow>
{
    if (PMob->spawnWindow().has_value())
    {
        return PMob->spawnWindow();
    }

    if ((PMob->m_SpawnType & xi::SpawnType::AtNight) != xi::SpawnType::Normal)
    {
        return SpawnWindow{ 20, 4 };
    }

    if ((PMob->m_SpawnType & xi::SpawnType::AtEvening) != xi::SpawnType::Normal)
    {
        return SpawnWindow{ 18, 6 };
    }

    return std::nullopt;
}

} // namespace

SpawnHandler::SpawnHandler(CZone* PZone)
: zone_(PZone)
{
}

SpawnHandler::~SpawnHandler() = default;

auto SpawnHandler::getOrCreateSpawnSlot(uint32_t slotId) -> SpawnSlot*
{
    auto& spawnSlot = spawnSlots_[slotId];
    if (!spawnSlot)
    {
        spawnSlot = std::make_unique<SpawnSlot>();
    }
    return spawnSlot.get();
}

auto SpawnHandler::getSpawnSlot(uint32_t slotId) const -> SpawnSlot*
{
    const auto it = spawnSlots_.find(slotId);
    return it != spawnSlots_.end() ? it->second.get() : nullptr;
}

// Register a given mob for respawn at its default respawn timer.
// Respawn timer can optionally be overriden for deaggro/scripting purposes.
void SpawnHandler::registerForRespawn(CMobEntity* PMob, const Maybe<timer::duration> respawnTime)
{
    if (!PMob || !PMob->m_AllowRespawn || PMob->PInstance != nullptr)
    {
        return;
    }

    const timer::duration   duration  = respawnTime.value_or(PMob->m_RespawnTime);
    const timer::time_point respawnAt = timer::now() + duration;

    if (auto slot = PMob->GetSpawnSlot())
    {
        // Only a non-zero timer (deaggro/scripting) pins the respawn to this mob; otherwise the slot re-rolls.
        const auto specificMobId   = (respawnTime.has_value() && *respawnTime > timer::duration::zero())
                                         ? Maybe<uint32>(PMob->id)
                                         : std::nullopt;
        pendingSlotRespawns_[slot] = { respawnAt, specificMobId };
    }
    else
    {
        pendingRespawns_[PMob->id] = respawnAt;
    }
}

void SpawnHandler::unregister(CMobEntity* PMob)
{
    if (!PMob)
    {
        return;
    }

    if (SpawnSlot* slot = PMob->GetSpawnSlot())
    {
        pendingSlotRespawns_.erase(slot);
    }
    else
    {
        pendingRespawns_.erase(PMob->id);
    }
}

auto SpawnHandler::isRegistered(CMobEntity* PMob) const -> bool
{
    if (!PMob)
    {
        return false;
    }

    if (SpawnSlot* slot = PMob->GetSpawnSlot())
    {
        return pendingSlotRespawns_.contains(slot);
    }

    return pendingRespawns_.contains(PMob->id);
}

auto SpawnHandler::getRemainingRespawnTime(CMobEntity* PMob) const -> Maybe<timer::duration>
{
    if (!PMob)
    {
        return std::nullopt;
    }

    const auto now = timer::now();

    if (SpawnSlot* slot = PMob->GetSpawnSlot())
    {
        if (auto it = pendingSlotRespawns_.find(slot); it != pendingSlotRespawns_.end())
        {
            const auto remaining = it->second.respawnAt - now;
            return remaining > timer::duration::zero() ? remaining : timer::duration::zero();
        }
    }
    else
    {
        if (auto it = pendingRespawns_.find(PMob->id); it != pendingRespawns_.end())
        {
            const auto remaining = it->second - now;
            return remaining > timer::duration::zero() ? remaining : timer::duration::zero();
        }
    }

    return std::nullopt;
}

// Every 30 seconds, attempt to spawn any mob pending respawn.
// Mobs are respawned if:
// - Their respawn timer is due within the next 15s (half interval)
// - AND all spawn conditions are met (TOTD, Weather...)
// - AND the lua did not decide to cancel the spawn
// Mobs not meeting ANY of the above conditions will be considered again on the next wave.
void SpawnHandler::Tick(const timer::time_point now)
{
    const timer::time_point spawnThreshold = now + spawnWindow_;

    std::vector<CMobEntity*> mobsToSpawn;

    // Process non-slotted mobs
    // Unqualified: ADL finds ankerl's erase_if for FlatHashMap
    erase_if(
        pendingRespawns_,
        [&](const auto& pair)
        {
            if (pair.second > spawnThreshold)
            {
                return false;
            }

            const uint16 targid = static_cast<uint16>(pair.first & 0x0FFF);
            auto*        PMob   = static_cast<CMobEntity*>(zone_->GetEntity(targid, TYPE_MOB));

            if (!PMob)
            {
                return true;
            }

            if (!canSpawnNow(PMob) || luautils::OnMobSpawnCheck(PMob) != 0)
            {
                return false;
            }

            mobsToSpawn.push_back(PMob);
            return true;
        });

    for (auto* PMob : mobsToSpawn)
    {
        PMob->Spawn();
    }

    // Process slotted spawns
    // Unqualified: ADL finds ankerl's erase_if for FlatHashMap
    erase_if(
        pendingSlotRespawns_,
        [&](const auto& pair)
        {
            if (pair.second.respawnAt > spawnThreshold)
            {
                return false;
            }

            SpawnSlot* slot = pair.first;
            return !slot || slot->TrySpawn(pair.second.specificMobId);
        });
}

// Despawn mobs now outside their spawn window. Not tied to 30s task.
void SpawnHandler::onGameHour(const uint32 hour) const
{
    const bool zoneActive = zone_->IsZoneActive();

    zone_->ForEachMob(
        [zoneActive, hour](CMobEntity* PMob)
        {
            const auto window = spawnWindowOf(PMob);
            if (window.has_value() && PMob->isAlive() && !hourInWindow(hour, window->spawnHour, window->despawnHour))
            {
                if (zoneActive)
                {
                    PMob->SetDespawnTime(1ms);
                }
                else
                {
                    // Sleeping zone -> process the despawn immediately since AI doesnt tick on its own
                    PMob->PAI->Despawn();
                }
            }
        });
}

// On Weather change, process all relevant despawns.
// This is not tied to the 30s task.
void SpawnHandler::onWeatherChange(xi::Weather weather) const
{
    const auto element = zoneutils::GetWeatherElement(weather);
    zone_->ForEachMob(
        [weather, element](CMobEntity* PMob)
        {
            if (PMob->m_EcoSystem == xi::Ecosystem::Elemental && PMob->PMaster == nullptr && (PMob->m_SpawnType & xi::SpawnType::Weather) != xi::SpawnType::Normal)
            {
                if (PMob->m_Element != element)
                {
                    PMob->SetDespawnTime(1s);
                }
            }
            else if ((PMob->m_SpawnType & xi::SpawnType::Fog) != xi::SpawnType::Normal)
            {
                if (weather != xi::Weather::Fog)
                {
                    PMob->SetDespawnTime(1s);
                }
            }
        });
}

// Ensures the mob meets all conditions for spawning on current wave: TOTD, Weather, Respawn disabled etc.
auto SpawnHandler::canSpawnNow(const CMobEntity* PMob) const -> bool
{
    if (!PMob || !PMob->m_AllowRespawn)
    {
        return false;
    }

    // Time-based spawn conditions
    if (const auto window = spawnWindowOf(PMob); window.has_value())
    {
        if (!hourInWindow(vanadiel_time::get_hour(), window->spawnHour, window->despawnHour))
        {
            return false;
        }
    }

    // Weather-based spawn conditions
    if ((PMob->m_SpawnType & xi::SpawnType::Fog) != xi::SpawnType::Normal)
    {
        if (zone_->weather().current() != xi::Weather::Fog)
        {
            return false;
        }
    }

    if ((PMob->m_SpawnType & xi::SpawnType::Weather) != xi::SpawnType::Normal)
    {
        // Only for elementals without a master
        if (PMob->m_EcoSystem == xi::Ecosystem::Elemental && PMob->PMaster == nullptr)
        {
            if (PMob->m_Element != zoneutils::GetWeatherElement(zone_->weather().current()))
            {
                return false;
            }
        }
    }

    return true;
}
