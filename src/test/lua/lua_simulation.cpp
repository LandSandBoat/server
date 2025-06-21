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

#include "conquest_data.h"
#include "conquest_system.h"
#include "in_memory_sink.h"
#include "map/ai/ai_container.h"
#include "map/lua/lua_baseentity.h"
#include "map/map_networking.h"
#include "map/utils/charutils.h"
#include "map/utils/zoneutils.h"
#include "map/zone.h"

#include "test_char.h"

#include "lua_sim_client.h"
#include "map/map_server.h"

CLuaSimulation::CLuaSimulation(MapServer* _mapServer, const std::shared_ptr<InMemorySink>& _sink)
: m_engine(_mapServer)
, m_sink(_sink)
{
}

/************************************************************************
 *  Function: createPlayerClient()
 *  Purpose : Creates a new test character and returns the associated client.
 *  Example : sim:createPlayerClient({ zone = xi.zone.RABAO })
 *  Notes   :
 ************************************************************************/

auto CLuaSimulation::createPlayerClient(const sol::object& zoneIdObj) -> std::optional<std::reference_wrapper<CLuaSimClient>>
{
    uint16 zoneId = zoneIdObj.is<uint16>() ? zoneIdObj.as<uint16>() : 210;
    zoneutils::LoadZones({ zoneId });
    auto testChar = TestChar::create(zoneId);

    if (!testChar)
    {
        return std::nullopt;
    }

    testChar->setIpp(IPP(testChar->getCharId(), 12345));

    // Insert account session with dummy values
    uint8 key3[20]{};

    const auto rset = db::preparedStmt("INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr,version_mismatch) "
                                       "VALUES(?,?,?,?,?,?,?)",
                                       testChar->getAccountId(), testChar->getCharId(), key3, 0, 0, testChar->getCharId(), 0);
    if (!rset)
    {
        ShowError("Unable to create session for account.");

        return std::nullopt;
    }

    auto* session = m_engine->networking().sessions().createSession(testChar->getIpp());

    session->client_packet_id = 0;
    session->server_packet_id = 0;

    // Load char
    auto* PChar = charutils::LoadChar(testChar->getCharId());

    testChar->setSession(session);
    testChar->setEntity(PChar);

    return *m_clients.emplace_back(std::make_unique<CLuaSimClient>(std::move(testChar), this, m_engine));
}

/************************************************************************
 *  Function: loadZones()
 *  Purpose : Force load of zones.
 *  Example : sim:loadZones(xi.zone.RABAO, xi.zone.MHAURA)
 *  Notes   : Only required when events teleport to zones that are not currently loaded.
 ************************************************************************/

void CLuaSimulation::loadZones(sol::variadic_args va) const
{
    std::vector<uint16> zoneIds;
    for (auto&& zoneId : va)
    {
        zoneIds.push_back(zoneId);
    }

    zoneutils::LoadZones(zoneIds);
}

/************************************************************************
 *  Function: clean()
 *  Purpose : Cleans up the simulation. Resets PRNG and clears clients.
 *  Example : sim:clean()
 *  Notes   :
 ************************************************************************/

void CLuaSimulation::clean()
{
    m_clients.clear();
    xirand::seed();
}

/************************************************************************
 *  Function: tick()
 *  Purpose : Ticks all entities in the simulation, executes expired tasks.
 *  Example : sim:tick()
 *  Notes   : Will advance time if provided.
 ************************************************************************/

void CLuaSimulation::tick(const std::optional<uint32> timeSeconds) const
{
    ShowDebug("Ticking world");
    if (timeSeconds.has_value())
    {
        ShowDebug("Moving clock offset forward and executing tasks");
        timer::add_offset_seconds(timeSeconds.value());
        vanadiel_time::add_offset_seconds(timeSeconds.value());
        CTaskManager::getInstance()->doExpiredTasks(timer::now());
    }

    ShowDebug("Ticking clients");
    for (auto&& client : m_clients)
    {
        client->tick();
    }

    ShowDebug("Executing tasks");
    CTaskManager::getInstance()->doExpiredTasks(timer::now());
}

/************************************************************************
 *  Function: tickEntity()
 *  Purpose : Ticks a specific entity.
 *  Example : sim:tickEntity(player)
 *  Notes   : Does not advance time, does not process expired tasks.
 ************************************************************************/

void CLuaSimulation::tickEntity(CLuaBaseEntity& entity) const
{
    ShowDebugFmt("Ticking Entity: {}", entity.getName());
    entity.GetBaseEntity()->PAI->Tick(timer::now());
}

/************************************************************************
 *  Function: addSeconds()
 *  Purpose : Moves clock forward by the number of seconds.
 *  Example : sim:addSeconds(30)
 *  Notes   : Simulates the passage of time in the simulation.
 ************************************************************************/

void CLuaSimulation::addSeconds(uint32 seconds) const
{
    ShowDebugFmt("Adding {} seconds to clock", seconds);
    timer::add_offset_seconds(seconds);
    vanadiel_time::add_offset_seconds(seconds);
    ShowDebug("Executing tasks");
    CTaskManager::getInstance()->doExpiredTasks(timer::now());
}

/************************************************************************
 *  Function: setRegionOwner()
 *  Purpose : Sets a specific region to be controlled by given nation.
 *  Example : sim:setRegionOwner(xi.region.XXX, xi.nation.YYY)
 *  Notes   :
 ************************************************************************/

void CLuaSimulation::setRegionOwner(uint8 region, uint8 nation) const
{
    ShowDebugFmt("Updating region owner to {} for region {}", nation, region);
    auto rset = db::preparedStmt("UPDATE conquest_system SET region_control = ? WHERE region_id = ?",
                                 nation, region);

    if (!rset)
    {
        ShowError("Unable to update region owner.");
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

        ShowInfo("Refreshing conquest system");
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
    // TODO: 0% chance this works relibly.
    xirand::rng().seed(seed);
}

/************************************************************************
 *  Function: seed()
 *  Purpose : Initializes the PRNG to a new random seed.
 *  Example : sim:seed()
 *  Notes   : Automatically called at the end of each test.
 ************************************************************************/

void CLuaSimulation::seed() const
{
    xirand::seed();
}

/************************************************************************
 *  Function: getLogs()
 *  Purpose : Returns all logs from the in-memory sink.
 *  Example : sim:getLogs()
 *  Notes   :
 ************************************************************************/

auto CLuaSimulation::getLogs() const -> sol::table
{
    sol::table logs = lua.create_table();

    int index = 1;
    for (auto&& log : m_sink->getLogs())
    {
        logs[index++] = log;
    }

    return logs;
}

/************************************************************************
 *  Function: clearLogs()
 *  Purpose : Removes every buffered log entries.
 *  Example : sim:clearLogs()
 *  Notes   : Automatically called at the end of each test.
 ************************************************************************/

void CLuaSimulation::clearLogs() const
{
    m_sink->clear();
}

void CLuaSimulation::Register()
{
    SOL_USERTYPE("CSimulation", CLuaSimulation);
    SOL_REGISTER("createPlayerClient", CLuaSimulation::createPlayerClient);
    SOL_REGISTER("tick", CLuaSimulation::tick);
    SOL_REGISTER("tickEntity", CLuaSimulation::tickEntity);
    SOL_REGISTER("addSeconds", CLuaSimulation::addSeconds);
    SOL_REGISTER("setRegionOwner", CLuaSimulation::setRegionOwner);
    SOL_REGISTER("loadZones", CLuaSimulation::loadZones);
    SOL_REGISTER("clean", CLuaSimulation::clean);
    SOL_REGISTER("setSeed", CLuaSimulation::setSeed);
    SOL_REGISTER("seed", CLuaSimulation::seed);
    SOL_REGISTER("getLogs", CLuaSimulation::getLogs);
    SOL_REGISTER("clearLogs", CLuaSimulation::clearLogs);
};
