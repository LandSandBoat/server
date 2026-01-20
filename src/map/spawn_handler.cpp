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

#include "common/timer.h"
#include "common/vana_time.h"
#include "entities/mobentity.h"
#include "enums/weather.h"
#include "lua/luautils.h"
#include "spawn_slot.h"
#include "utils/zoneutils.h"
#include "zone.h"

SpawnHandler::SpawnHandler(CZone* PZone)
: zone_(PZone)
{
}

// Register a given mob for respawn at its default respawn timer.
// Respawn timer can optionally be overriden for deaggro/scripting purposes.
void SpawnHandler::registerForRespawn(CMobEntity* PMob, const std::optional<timer::duration> respawnTime)
{
    if (!PMob || !PMob->m_AllowRespawn || PMob->PInstance != nullptr)
    {
        return;
    }

    const timer::duration   duration  = respawnTime.value_or(PMob->m_RespawnTime);
    const timer::time_point respawnAt = timer::now() + duration;

    if (SpawnSlot* slot = PMob->GetSpawnSlot())
    {
        const std::optional<uint32> specificMobId = respawnTime.has_value() ? std::optional(PMob->id) : std::nullopt;
        pendingSlotRespawns_[slot]                = { respawnAt, specificMobId };
    }
    else
    {
        pendingRespawns_[PMob->id] = respawnAt;
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

// Every 30 seconds, attempt to spawn any mob pending respawn.
// Mobs are respawned if:
// - Their respawn timer is due within the next 15s (half interval)
// - AND all spawn conditions are met (TOTD, Weather...)
// - AND the lua did not decide to cancel the spawn
// Mobs not meeting ANY of the above conditions will be considered again on the next wave.
void SpawnHandler::Tick(const timer::time_point now)
{
    const timer::time_point spawnThreshold = now + spawnWindow_;

    // Process non-slotted mobs
    std::erase_if(pendingRespawns_, [&](const auto& pair)
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

                      PMob->Spawn();
                      return true;
                  });

    // Process slotted spawns
    std::erase_if(pendingSlotRespawns_, [&](const auto& pair)
                  {
                      if (pair.second.respawnAt > spawnThreshold)
                      {
                          return false;
                      }

                      SpawnSlot* slot = pair.first;
                      return !slot || slot->TrySpawn(pair.second.specificMobId);
                  });
}

// On TOTD change, process all relevant despawns.
// This is not tied to the 30s task.
void SpawnHandler::onTOTDChange(const vanadiel_time::TOTD totd) const
{
    switch (totd)
    {
        case vanadiel_time::TOTD::NEWDAY:
        {
            zone_->ForEachMob([](CMobEntity* PMob)
                              {
                                  if (PMob->m_SpawnType & SPAWNTYPE_ATNIGHT)
                                  {
                                      PMob->SetDespawnTime(1ms);
                                  }
                              });
        }
        break;
        case vanadiel_time::TOTD::DAWN:
        {
            zone_->ForEachMob([](CMobEntity* PMob)
                              {
                                  if (PMob->m_SpawnType & SPAWNTYPE_ATEVENING)
                                  {
                                      PMob->SetDespawnTime(1ms);
                                  }
                              });
        }
        break;
        default:
            break;
    }
}

// On Weather change, process all relevant despawns.
// This is not tied to the 30s task.
void SpawnHandler::onWeatherChange(Weather weather) const
{
    const auto element = zoneutils::GetWeatherElement(weather);
    zone_->ForEachMob([weather, element](CMobEntity* PMob)
                      {
                          if (PMob->m_EcoSystem == ECOSYSTEM::ELEMENTAL && PMob->PMaster == nullptr && PMob->m_SpawnType & SPAWNTYPE_WEATHER)
                          {
                              if (PMob->m_Element != element)
                              {
                                  PMob->SetDespawnTime(1s);
                              }
                          }
                          else if (PMob->m_SpawnType & SPAWNTYPE_FOG)
                          {
                              if (weather != Weather::Fog)
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
    const auto totd = vanadiel_time::get_totd();
    if (PMob->m_SpawnType & SPAWNTYPE_ATNIGHT)
    {
        // 20:00-04:00 (NIGHT, MIDNIGHT)
        if (totd != vanadiel_time::TOTD::NIGHT && totd != vanadiel_time::TOTD::MIDNIGHT)
        {
            return false;
        }
    }

    if (PMob->m_SpawnType & SPAWNTYPE_ATEVENING)
    {
        // 18:00-06:00 (EVENING, NIGHT, MIDNIGHT, NEWDAY)
        if (totd != vanadiel_time::TOTD::EVENING &&
            totd != vanadiel_time::TOTD::NIGHT &&
            totd != vanadiel_time::TOTD::MIDNIGHT &&
            totd != vanadiel_time::TOTD::NEWDAY)
        {
            return false;
        }
    }

    // Weather-based spawn conditions
    if (PMob->m_SpawnType & SPAWNTYPE_FOG)
    {
        if (zone_->GetWeather() != Weather::Fog)
        {
            return false;
        }
    }

    if (PMob->m_SpawnType & SPAWNTYPE_WEATHER)
    {
        // Only for elementals without a master
        if (PMob->m_EcoSystem == ECOSYSTEM::ELEMENTAL && PMob->PMaster == nullptr)
        {
            if (PMob->m_Element != zoneutils::GetWeatherElement(zone_->GetWeather()))
            {
                return false;
            }
        }
    }

    return true;
}
