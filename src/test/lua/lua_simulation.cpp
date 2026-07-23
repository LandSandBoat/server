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

#include "lua_simulation.h"

#include "common/vana_time.h"
#include "enums/tick_type.h"
#include "helpers/lua_client_entity_pair_packets.h"
#include "lua_client_entity_pair.h"
#include "lua_test_entity.h"
#include "map/ai/ai_container.h"
#include "map/conquest_data.h"
#include "map/conquest_system.h"
#include "map/entities/base_entity.h"
#include "map/entities/mob_entity.h"
#include "map/lua/lua_base_entity.h"
#include "map/lua/luautils.h"
#include "map/map_constants.h"
#include "map/map_engine.h"
#include "map/map_networking.h"
#include "map/spawn_slot.h"
#include "map/time_server.h"
#include "map/utils/zoneutils.h"
#include "map/zone.h"
#include "map/zone_entities.h"
#include "spawn_handler.h"
#include "test_char.h"
#include "test_common.h"

#include <algorithm>
#include <ranges>

namespace
{

auto durationToVanaTime = [](const uint8 vanaHour, const uint8 vanaMinute) -> earth_time::duration
{
    const auto vanaNow    = vanadiel_time::now();
    auto       vanaTarget = std::chrono::floor<xi::vanadiel_clock::days>(vanaNow) + xi::vanadiel_clock::hours(vanaHour) + xi::vanadiel_clock::minutes(vanaMinute);

    if (vanaTarget <= vanaNow)

    {
        vanaTarget += xi::vanadiel_clock::days(1);
    }

    return std::chrono::duration_cast<earth_time::duration>(vanaTarget - vanaNow);
};

} // namespace

CLuaSimulation::CLuaSimulation(MapEngine* _mapServer, const std::shared_ptr<InMemorySink>& _sink)
: engine_{ _mapServer }
, sink_{ _sink }
{
}

void CLuaSimulation::cleanClients(Maybe<ClientScope> scope)
{
    if (!scope.has_value())
    {
        // No scope specified - clean all clients
        clients_.clear();
    }
    else
    {
        // Clean only clients with matching scope

        auto [first, last] = std::ranges::remove_if(
            clients_,
            [scope](const ClientInfo& info)
            {
                return info.scope == scope.value();
            });

        clients_.erase(first, last);
    }
}

/************************************************************************
 *  Function: tickEntity()
 *  Purpose : Ticks the entity AI once.
 *  Example : sim:tickEntity(mob)
 *  Notes   :
 ************************************************************************/

void CLuaSimulation::tickEntity(CLuaBaseEntity& entity) const
{
    TracyZoneScoped;

    DebugTestFmt("Ticking entity: {} (ID: {})", entity.getName(), entity.GetBaseEntity()->id);

    // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
    engine_->scheduler().blockOnMainThread(
        entity.GetBaseEntity()->PAI->Tick(timer::now()));
}

/************************************************************************
 *  Function: skipTime()
 *  Purpose : Moves the steady clock forward by given number of seconds.
 *  Example : sim:skipTime(300) -- skip 5 minutes
 *  Notes   : Ticks the world once.
 *            Does not affect Vana'diel time. See setVanaTime() for that.
 ************************************************************************/

void CLuaSimulation::skipTime(uint32 seconds) const
{
    TracyZoneScoped;

    ShowInfoFmt("Skipping {} seconds", seconds);

    // Advance time by the requested amount
    timer::add_offset(std::chrono::seconds(seconds));
    tick();
}

/************************************************************************
 *  Function: setVanaTime()
 *  Purpose : Sets to specific Vana'diel time.
 *  Example : sim:setVanaTime(6, 0) -- set to 6:00am
 *  Notes   : Will skip to next day if past the given time.
 *            Does not tick. Does not affect steady clock.
 ************************************************************************/

void CLuaSimulation::setVanaTime(const uint8 vanaHour, const uint8 vanaMinute) const
{
    ShowInfoFmt("Skipping to Vana'diel time {:02d}:{:02d}", vanaHour, vanaMinute);

    const auto prevTotd = vanadiel_time::get_totd();
    earth_time::add_offset(durationToVanaTime(vanaHour, vanaMinute));
    const auto newTotd = vanadiel_time::get_totd();

    if (newTotd != prevTotd)
    {
        zoneutils::TOTDChange(newTotd);
    }

    DebugTestFmt("Vana'Diel time is now {:02d}:{:02d} (day {})", vanadiel_time::get_hour(), vanadiel_time::get_minute(), vanadiel_time::get_weekday());
}

/************************************************************************
 *  Function: setVanaDay()
 *  Purpose : Sets to given Vana'diel day of the week.
 *  Example : sim:setVanaDay(xi.day.DARKSDAY)
 *  Notes   : Will skip to next week if already on the given day.
 *          : Does not tick. Does not affect steady clock.
 ************************************************************************/

void CLuaSimulation::setVanaDay(const uint8 day) const
{
    ShowInfoFmt("Skipping to Vana'diel day {} at 00:00", day);

    // First set to midnight (0:00) of next day
    earth_time::add_offset(durationToVanaTime(0, 0));

    // Now skip to the target day
    int daysToSkip = day - vanadiel_time::get_weekday();
    if (daysToSkip < 0)
    {
        daysToSkip = daysToSkip + 8;
    }

    if (daysToSkip > 0)
    {
        earth_time::add_offset(std::chrono::duration_cast<earth_time::duration>(xi::vanadiel_clock::days(daysToSkip)));
    }

    DebugTestFmt("Vana'Diel time is now {:02d}:{:02d} (day {})", vanadiel_time::get_hour(), vanadiel_time::get_minute(), vanadiel_time::get_weekday());
}

/************************************************************************
 *  Function: skipToNextVanaDay()
 *  Purpose : Skips to midnight (00:00) of the next Vana'diel day
 *  Example : sim:skipToNextVanaDay()
 *  Notes   : Always advances by exactly one day, handles wrap-around
 ************************************************************************/

void CLuaSimulation::skipToNextVanaDay() const
{
    setVanaDay((vanadiel_time::get_weekday() + 1) % 8);
}

/************************************************************************
 *  Function: skipVanaDays()
 *  Purpose : Advances Vana'diel time by whole days.
 *  Example : sim:skipVanaDays(30)
 *  Notes   : Vana'diel time only (like setVanaTime); does not tick.
 ************************************************************************/

void CLuaSimulation::skipVanaDays(const uint32 days) const
{
    ShowInfoFmt("Skipping {} Vana'diel days", days);

    earth_time::add_offset(std::chrono::duration_cast<earth_time::duration>(xi::vanadiel_clock::days(days)));
}

/************************************************************************
 *  Function: setRegionOwner()
 *  Purpose : Sets a specific region to be controlled by given nation.
 *  Example : sim:setRegionOwner(xi.region.XXX, xi.nation.YYY)
 *  Notes   :
 ************************************************************************/

void CLuaSimulation::setRegionOwner(REGION_TYPE region, NATION_TYPE nation) const
{
    DebugTestFmt("Setting region {} owner to nation {}", static_cast<uint8>(region), static_cast<uint8>(nation));
    auto rset = db::preparedStmt("UPDATE conquest_system SET region_control = ? WHERE region_id = ?",
                                 static_cast<uint8>(nation),
                                 static_cast<uint8>(region));

    if (!rset)
    {
        TestError("Unable to update region owner.");
        return;
    }

    rset = db::preparedStmt("SELECT region_control, region_control_prev FROM conquest_system");

    if (rset && rset->rowsCount())
    {
        std::vector<region_control_t> controllers;
        while (rset->next())
        {
            region_control_t regionControl{};
            regionControl.current = rset->get<uint8>("region_control");
            regionControl.prev    = rset->get<uint8>("region_control_prev");
            controllers.emplace_back(regionControl);
        }

        DebugTest("Refreshing conquest system");
        conquest::HandleWeeklyTallyEnd(controllers);
    }
}

/************************************************************************
 *  Function: setSeed()
 *  Purpose : Sets the PRNG to a specific seed.
 *  Example : sim:setSeed(12345)
 *  Notes   : Is reset after each individual tests.
 ************************************************************************/

void CLuaSimulation::setSeed(const uint64 seed) const
{
    DebugTestFmt("Setting PRNG seed: {}", seed);
    xirand::rng().seed(seed);
}

/************************************************************************
 *  Function: seed()
 *  Purpose : Initializes the PRNG to a new random seed.
 *  Example : sim:seed()
 *  Notes   :
 ************************************************************************/

void CLuaSimulation::seed() const
{
    xirand::seed();
}

/************************************************************************
 *  Function: resetWeather()
 *  Purpose : Clears weather set by a previous test.
 *  Notes   : Zone weather is global and automated weather is disabled under
 *            test, so without this a setWeather() call leaks into every
 *            later test in that zone.
 ************************************************************************/

void CLuaSimulation::resetWeather() const
{
    zoneutils::ForEachZone(
        [](CZone* PZone)
        {
            PZone->SetWeather(xi::Weather::None);
        });
}

// Moves all clients session clock and process pending packets
void CLuaSimulation::processClientUpdates() const
{
    TracyZoneScoped;

    for (auto&& info : clients_)
    {
        info.client->tick();
    }
}

/************************************************************************
 *  Function: tick()
 *  Purpose : Moves clocks forward to the next occurrence of the specified tick type.
 *  Example : xi.test.world:tick(xi.tick.JST_DAILY)
 *  Notes   : If no args, defaults to xi.tick.ZONE.
 *          : Will advance to the least time required and execute associated tasks.
 *          : This does not execute unrelated tasks, when possible.
 ************************************************************************/

void CLuaSimulation::tick(const Maybe<TickType> boundary) const
{
    TracyZoneScoped;

    if (boundary)
    {
        switch (*boundary)
        {
            case TickType::ZoneTick:
                TracyZoneCString("Zone Tick");
                break;
            case TickType::TimeServer:
                TracyZoneCString("Time Server Tick");
                break;
            case TickType::EffectTick:
                TracyZoneCString("Effect Tick");
                break;
            case TickType::TriggerAreas:
                TracyZoneCString("Trigger Areas Tick");
                break;
            case TickType::JSTHourly:
                TracyZoneCString("JST Hourly Tick");
                break;
            case TickType::JSTDaily:
                TracyZoneCString("JST Daily Tick");
                break;
            case TickType::VanadielHourly:
                TracyZoneCString("Vanadiel Hourly Tick");
                break;
            case TickType::VanadielDaily:
                TracyZoneCString("Vanadiel Daily Tick");
                break;
            case TickType::SpawnHandler:
                TracyZoneCString("Spawn Handler Tick");
                break;
        }
    }
    else
    {
        TracyZoneCString("Zone Tick");
    }

    // Timer clock may be offset, so calculate Earth/Vana time instead of directly using those clocks.
    const auto timerAdjustedUtcTime = timer::to_utc();
    const auto adjustedVanaTime     = vanadiel_time::from_earth_time(timerAdjustedUtcTime);

    const auto nextJstHourlyUpdate = std::chrono::ceil<std::chrono::hours>(timerAdjustedUtcTime);
    const auto nextJstDailyUpdate  = earth_time::jst::get_next_midnight(timerAdjustedUtcTime);

    const auto nextVHourlyUpdate = std::chrono::ceil<xi::vanadiel_clock::hours>(adjustedVanaTime);
    const auto nextVDailyUpdate  = std::chrono::ceil<xi::vanadiel_clock::days>(adjustedVanaTime);

    // Default to ZoneTick if no type specified
    switch (boundary.value_or(TickType::ZoneTick))
    {
        case TickType::ZoneTick:
        {
            // Generic zone tick. Advances all AIs etc.
            timer::add_offset(kLogicUpdateInterval);
            const auto timePoint = timer::now() + 1ms;
            for (auto* PZone : g_PZoneList | std::views::values)
            {
                if (!PZone->GetZoneEntities()->CharListEmpty()) // Only tick zones with players
                {
                    // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
                    engine_->scheduler().blockOnMainThread(PZone->ZoneServer(timePoint));
                }
            }
        }
        break;
        case TickType::TriggerAreas:
        {
            // Check trigger areas and start associated events, if any.
            timer::add_offset(kTriggerAreaInterval);
            const auto timePoint = timer::now() + 1ms;
            for (auto* PZone : g_PZoneList | std::views::values)
            {
                if (!PZone->GetZoneEntities()->CharListEmpty())
                {
                    // CheckTriggerAreas _only_ adds a trigger area to the player list.
                    // ZoneServer processes the actual events.

                    // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
                    engine_->scheduler().blockOnMainThread(PZone->CheckTriggerAreas());
                    engine_->scheduler().blockOnMainThread(PZone->ZoneServer(timePoint));
                }
            }
        }
        break;
        case TickType::TimeServer:
        {
            // Execute time_server with no specific task in mind.
            timer::add_offset(kTimeServerTickInterval);

            // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
            engine_->scheduler().blockOnMainThread(time_server(engine_->scheduler(), engine_->config()));
        }
        break;
        case TickType::EffectTick:
        {
            // Find the furthest point that will tick effects in all currently loaded zones.
            auto maxEffectCheckTime = timer::time_point::min();
            for (auto* PZone : g_PZoneList | std::views::values)
            {
                auto effectCheckTime = PZone->GetZoneEntities()->GetEffectCheckTime();
                if (effectCheckTime > maxEffectCheckTime)
                {
                    maxEffectCheckTime = effectCheckTime;
                }
            }

            const auto effectDuration = std::chrono::duration_cast<std::chrono::milliseconds>(maxEffectCheckTime - timer::now());
            timer::add_offset(std::max(effectDuration, kLogicUpdateInterval) + 1ms);

            const auto timePoint = timer::now();
            for (auto* PZone : g_PZoneList | std::views::values)
            {
                if (!PZone->GetZoneEntities()->CharListEmpty())
                {
                    // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
                    engine_->scheduler().blockOnMainThread(PZone->GetZoneEntities()->ZoneServer(timePoint));
                }
            }
        }
        break;
        case TickType::JSTHourly:
        {
            // Skip to next JST Hourly and execute time_server
            timer::add_offset(kTimeServerTickInterval);
            earth_time::add_offset(nextJstHourlyUpdate - timerAdjustedUtcTime);

            // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
            engine_->scheduler().blockOnMainThread(time_server(engine_->scheduler(), engine_->config()));
        }
        break;
        case TickType::JSTDaily:
        {
            // Skip to next JST Daily and execute time_server
            timer::add_offset(kTimeServerTickInterval);
            earth_time::add_offset(nextJstDailyUpdate - timerAdjustedUtcTime);

            // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
            engine_->scheduler().blockOnMainThread(time_server(engine_->scheduler(), engine_->config()));
        }
        break;
        case TickType::VanadielHourly:
        {
            // Skip to next VanaDiel Hourly and execute time_server
            timer::add_offset(kTimeServerTickInterval);
            earth_time::add_offset(vanadiel_time::to_earth_time(nextVHourlyUpdate) - timerAdjustedUtcTime);

            // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
            engine_->scheduler().blockOnMainThread(time_server(engine_->scheduler(), engine_->config()));
        }
        break;
        case TickType::VanadielDaily:
        {
            // Skip to next VanaDiel Daily and execute time_server
            timer::add_offset(kTimeServerTickInterval);
            earth_time::add_offset(vanadiel_time::to_earth_time(nextVDailyUpdate) - timerAdjustedUtcTime);

            // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
            engine_->scheduler().blockOnMainThread(time_server(engine_->scheduler(), engine_->config()));
        }
        break;
        case TickType::SpawnHandler:
        {
            // Tick spawn handlers for all zones
            timer::add_offset(kSpawnHandlerInterval);
            const auto timePoint = timer::now();
            for (const auto* PZone : g_PZoneList | std::views::values)
            {
                PZone->spawnHandler().Tick(timePoint);
            }
        }
        break;
    }

    processClientUpdates();
}

/************************************************************************
 *  Function: spawnPlayer()
 *  Purpose : Spawn a test player
 *  Example : player = world:spawnPlayer({zone = xi.zone.NORG})
 *  Notes   : Returns a single unified player object with all client functionality
 ************************************************************************/

auto CLuaSimulation::spawnPlayer(sol::optional<sol::table> params) -> CLuaClientEntityPair*
{
    TracyZoneScoped;

    uint16               zoneId = ZONE_GM_HOME;
    sol::optional<uint8> job;
    sol::optional<uint8> level;
    bool                 isNewPlayer = false;

    if (params.has_value())
    {
        const sol::table& paramTable = params.value();

        zoneId      = paramTable.get_or("zone", ZONE_GM_HOME);
        job         = paramTable.get<sol::optional<uint8>>("job");
        level       = paramTable.get<sol::optional<uint8>>("level");
        isNewPlayer = paramTable.get_or("new", false);
    }

    ShowInfoFmt("Spawning player in zone: {}", zoneId);

    auto testChar = TestChar::create(zoneId);

    if (!testChar)
    {
        TestError("Failed to create test character for zone {}", zoneId);
        return nullptr;
    }

    ShowInfoFmt("Created test character ID: {} in zone: {}", testChar->charId(), zoneId);

    testChar->setIpp(IPP(testChar->charId(), 12345));
    uint8      key3[20]{};
    const auto rset = db::preparedStmt("INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr,version_mismatch) "
                                       "VALUES(?,?,?,?,?,?,?)",
                                       testChar->accountId(),
                                       testChar->charId(),
                                       key3,
                                       0,
                                       0,
                                       testChar->charId(),
                                       0);
    if (!rset)
    {
        TestError("Unable to create session for account.");
        return nullptr;
    }

    auto* session             = engine_->networking().sessions().createSession(testChar->ipp());
    session->client_packet_id = 0;
    session->server_packet_id = 0;
    testChar->setSession(session);

    // Set playtime to non-zero so that firstLogin is false (avoids 120ms+ processing in OnGameIn)
    // Unless explicitly spawning a new player
    if (!isNewPlayer)
    {
        db::preparedStmt("UPDATE chars SET playtime = 60 WHERE charid = ?", testChar->charId());
    }

    // Create client wrapper and track setup context
    ClientInfo info{
        .client = std::make_unique<CLuaClientEntityPair>(std::move(testChar), this, engine_),
        .scope  = inSetupContext_ ? ClientScope::Suite : ClientScope::TestCase
    };
    clients_.push_back(std::move(info));

    auto* player = clients_.back().client.get();

    // Complete zone-in sequence
    player->packets().sendZonePackets();

    if (job.has_value())
    {
        player->changeJob(job.value());
    }

    if (level.has_value())
    {
        player->setLevel(level.value());
    }

    return player;
}

void CLuaSimulation::setSetupContext(const bool inSetup)
{
    inSetupContext_ = inSetup;
}

/************************************************************************
 *  Function: getSpawnSlot()
 *  Purpose : Returns mobs in a spawn slot as a Lua table.
 *  Example : local mobs = xi.test.world:getSpawnSlot(xi.zone.GHELSBA_OUTPOST, 1)
 *  Notes   : Throws an error if slot not found.
 ************************************************************************/

auto CLuaSimulation::getSpawnSlot(const ZONEID zoneId, const uint32 slotId) const -> sol::table
{
    auto result = lua.create_table();

    auto* PZone = zoneutils::GetZone(zoneId);
    if (!PZone)
    {
        TestError("Zone {} not found", static_cast<uint16_t>(zoneId));
        return result;
    }

    const auto* slot = PZone->spawnHandler().getSpawnSlot(slotId);
    if (!slot)
    {
        TestError("Spawn slot {} not found in zone {}", slotId, static_cast<uint16_t>(zoneId));
        return result;
    }

    const auto& entries = slot->GetEntries();
    auto        i       = 1;
    for (const auto& [mob, spawnChance] : entries)
    {
        if (mob)
        {
            result[i] = CLuaTestEntity(engine_->scheduler(), mob);
        }

        ++i;
    }

    return result;
}

void CLuaSimulation::Register()
{
    SOL_USERTYPE("CSimulation", CLuaSimulation);
    SOL_REGISTER("tick", CLuaSimulation::tick);
    SOL_REGISTER("tickEntity", CLuaSimulation::tickEntity);
    SOL_REGISTER("skipTime", CLuaSimulation::skipTime);
    SOL_REGISTER("setVanaTime", CLuaSimulation::setVanaTime);
    SOL_REGISTER("setVanaDay", CLuaSimulation::setVanaDay);
    SOL_REGISTER("skipToNextVanaDay", CLuaSimulation::skipToNextVanaDay);
    SOL_REGISTER("skipVanaDays", CLuaSimulation::skipVanaDays);
    SOL_REGISTER("setRegionOwner", CLuaSimulation::setRegionOwner);
    SOL_REGISTER("setSeed", CLuaSimulation::setSeed);
    SOL_REGISTER("seed", CLuaSimulation::seed);
    SOL_REGISTER("spawnPlayer", CLuaSimulation::spawnPlayer);
    SOL_REGISTER("getSpawnSlot", CLuaSimulation::getSpawnSlot);
};
