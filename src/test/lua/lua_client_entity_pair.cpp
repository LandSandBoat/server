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

#include "lua_client_entity_pair.h"
#include "common/lua.h"
#include "enums/tick_type.h"
#include "map/entities/baseentity.h"
#include "map/entities/charentity.h"
#include "map/item_container.h"
#include "map/items/item.h"
#include "map/lua/lua_baseentity.h"
#include "map/lua/sol_bindings.h"
#include "map/utils/charutils.h"
#include "map/utils/zoneutils.h"
#include "map/zone.h"
#include "map_engine.h"
#include "map_networking.h"
#include "test/lua/lua_simulation.h"
#include "test/lua/lua_spy.h"
#include "test_char.h"
#include "test_common.h"

#include <unordered_map>

// A test player that combines client and player entity functionality
// Common test patterns are exposed as properties
CLuaClientEntityPair::CLuaClientEntityPair(std::unique_ptr<TestChar> testChar, CLuaSimulation* simulation, MapEngine* mapServer)
: CLuaTestEntity(testChar->entity())
, testChar_(std::move(testChar))
, simulation_(simulation)
, engine_(mapServer)
{
}

CLuaClientEntityPair::~CLuaClientEntityPair()
{
    testChar_->clearPackets();

    if (testChar_->entity()->isInEvent())
    {
        ShowErrorFmt("Player was in event {} while logging out in {}",
                     testChar_->entity()->currentEvent->eventId,
                     testChar_->entity()->loc.zone->getName());
    }

    testChar_->session()->blowfish.status = BLOWFISH_PENDING_ZONE;
    engine_->networking().sessions().destroySession(testChar_->session());
}

/************************************************************************
 *  Function: tick()
 *  Purpose : Process incoming packets and update session timestamp
 *  Example : player:tick()
 *  Notes   : Should be called regularly to process network events
 ************************************************************************/

void CLuaClientEntityPair::tick()
{
    TracyZoneScoped;

    testChar_->session()->last_update = timer::now();
    packets().parseIncoming();
}

/************************************************************************
 *  Function: gotoZone()
 *  Purpose : Zone the player to a different zone with optional position
 *  Example : player:gotoZone(xi.zone.BASTOK_MINES)
 *            player:gotoZone(xi.zone.BASTOK_MINES, {x=100, y=0, z=-50, rot=64})
 *  Notes   : Will error if player is in an event during zoning
 ************************************************************************/

void CLuaClientEntityPair::gotoZone(ZONEID zoneId, sol::optional<sol::table> pos)
{
    // Check if player is in an event
    if (testChar_->entity()->isInEvent())
    {
        TestError("Player is in event {} while zoning to {}",
                  testChar_->entity()->currentEvent->eventId, zoneId);
        return;
    }

    ShowInfoFmt("Player {} zoning to zone ID: {}", testChar_->entity()->getName(), zoneId);

    if (zoneutils::GetZone(zoneId) == nullptr)
    {
        zoneutils::LoadZones({ zoneId });
    }

    // SendToZone _only_ prepares the character for zoning.
    testChar_->entity()->loc.destination = zoneId;
    testChar_->entity()->status          = STATUS_TYPE::DISAPPEAR;
    charutils::SendToZone(testChar_->entity(), zoneId);
    charutils::removeCharFromZone(testChar_->entity());
    packets().sendZonePackets(); // Send zone in packets, reload PChar

    // If position provided, set it and tick
    if (pos.has_value())
    {
        auto*      entity   = GetBaseEntity();
        sol::table posTable = pos.value();

        // Set the position directly using the table
        const float x   = posTable["x"].get_or<float>(entity->loc.p.x);
        const float y   = posTable["y"].get_or<float>(entity->loc.p.y);
        const float z   = posTable["z"].get_or<float>(entity->loc.p.z);
        const uint8 rot = posTable["rot"].get_or(posTable["rotation"].get_or<uint8>(entity->loc.p.rotation));

        entity->loc.p.x        = x;
        entity->loc.p.y        = y;
        entity->loc.p.z        = z;
        entity->loc.p.rotation = rot;

        // After setting position on zone-in, we MUST perform these ticks in sequence
        // Events will not be set if we don't!
        simulation_->tick(TickType::ZoneTick);
        simulation_->tick(TickType::TriggerAreas);
    }
}

/************************************************************************
 *  Function: isPendingZone()
 *  Purpose : Check if the player has a pending zone change request
 *  Example : if player:isPendingZone() then ... end
 *  Notes   : Returns true if zone change has been requested but not completed
 ************************************************************************/

auto CLuaClientEntityPair::isPendingZone() const -> bool
{
    return testChar_->entity()->requestedZoneChange;
}

/************************************************************************
 *  Function: getItemInvSlot()
 *  Purpose : Searches slot matching item ID and quantity
 *  Example : player:getItemInvSlot(xi.item.RIDILL, 1)
 *  Notes   : Only for LOC_INVENTORY, player-specific
 ************************************************************************/

auto CLuaClientEntityPair::getItemInvSlot(const uint16 itemId, const uint8 quantity) const -> std::optional<uint16>
{
    uint8       slotId = 0;
    const auto* PChar  = testChar_->entity();

    // clang-format off
    PChar->getStorage(LOC_INVENTORY)->ForEachItem([&](const CItem* item)
    {
        if (item->getID() == itemId && item->getQuantity() >= quantity)
        {
            slotId = item->getSlotID();
        }
    });
    // clang-format on

    if (slotId != 0)
    {
        return std::make_optional(slotId);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: claimAndKillMob()
 *  Purpose : Claim and kill a mob, handling death and optional despawn
 *  Example : player:claimAndKillMob(mob)
 ************************************************************************/

void CLuaClientEntityPair::claimAndKillMob(const sol::object& mobQuery, sol::optional<sol::table> params)
{
    // Get the mob entity
    const auto maybeMob = entities().get(mobQuery);
    if (!maybeMob)
    {
        TestError("Mob not found");
        return;
    }

    auto mob = maybeMob.value();

    // Check if spawned
    if (!mob.isSpawned())
    {
        TestError("{} is not spawned", mob.getName());
        return;
    }

    // Parse parameters
    bool expectDeath    = true;
    bool waitForDespawn = false;

    if (params.has_value())
    {
        sol::table paramTable = params.value();
        expectDeath           = paramTable["expectDeath"].get_or(true);
        waitForDespawn        = paramTable["waitForDespawn"].get_or(false);
    }

    // Add enmity and claim using Lua wrapper methods
    mob.addEnmity(this, 10, 10);

    // Create sol::object for methods that need it
    const sol::object playerObj = sol::make_object(lua.lua_state(), this);
    mob.updateClaim(playerObj);

    // Deal massive damage
    mob.takeDamage(2000000000, playerObj, sol::lua_nil, sol::lua_nil, sol::lua_nil);

    // Check death if expected
    if (expectDeath)
    {
        if (mob.getHP() != 0)
        {
            TestError("{} did not die.", mob.getName());
        }
    }

    // Trigger death
    simulation_->tickEntity(mob); // Trigger death
    simulation_->skipTime(1);     // Wait for mob to die
    simulation_->tickEntity(mob); // Trigger post-death
    simulation_->tick();

    // Handle despawn if not in battlefield
    if (waitForDespawn || !mob.getBattlefield())
    {
        mob.despawn();

        if (mob.isSpawned())
        {
            TestError("{} did not despawn. Current state is: {}",
                      mob.getName(), mob.getCurrentAction());
        }
    }
}

/************************************************************************
 *  Function: claimAndKillMobs()
 *  Purpose : Kill multiple mobs in sequence
 *  Example : player:claimAndKillMobs(mob1, mob2, mob3)
 ************************************************************************/

void CLuaClientEntityPair::claimAndKillMobs(sol::variadic_args mobQueries)
{
    for (const auto& mobQuery : mobQueries)
    {
        claimAndKillMob(mobQuery, sol::nullopt);
    }
}

/************************************************************************
 *  Property: actions
 *  Purpose : Retrieve the actions helper
 *  Example : player.actions:xxx()
 *  Notes   :
 ************************************************************************/

auto CLuaClientEntityPair::actions() -> CLuaClientEntityPairActions
{
    return CLuaClientEntityPairActions(this);
}

/************************************************************************
 *  Property: bcnm
 *  Purpose : Retrieve the bcnm helper
 *  Example : player.bcnm:xxx()
 *  Notes   :
 ************************************************************************/

auto CLuaClientEntityPair::bcnm() -> CLuaClientEntityPairBCNM
{
    return CLuaClientEntityPairBCNM(this);
}

/************************************************************************
 *  Property: events
 *  Purpose : Retrieve the events helper
 *  Example : player.events:xxx()
 *  Notes   :
 ************************************************************************/

auto CLuaClientEntityPair::events() -> CLuaClientEntityPairEvents
{
    return CLuaClientEntityPairEvents(this);
}

/************************************************************************
 *  Property: entities
 *  Purpose : Retrieve the entities helper
 *  Example : player.entities:xxx()
 *  Notes   :
 ************************************************************************/

auto CLuaClientEntityPair::entities() -> CLuaClientEntityPairEntities
{
    return CLuaClientEntityPairEntities(this);
}

/************************************************************************
 *  Property: packets
 *  Purpose : Retrieve the packets helper
 *  Example : player.packets:xxx()
 *  Notes   :
 ************************************************************************/

auto CLuaClientEntityPair::packets() -> CLuaClientEntityPairPackets
{
    return CLuaClientEntityPairPackets(this);
}

auto CLuaClientEntityPair::testChar() const -> TestChar*
{
    return testChar_.get();
}

auto CLuaClientEntityPair::simulation() const -> CLuaSimulation*
{
    return simulation_;
}

void CLuaClientEntityPair::Register()
{
    SOL_USERTYPE_INHERIT("CClientEntityPair", CLuaClientEntityPair, CLuaTestEntity, CLuaBaseEntity);
    SOL_REGISTER("tick", CLuaClientEntityPair::tick);
    SOL_REGISTER("gotoZone", CLuaClientEntityPair::gotoZone);
    SOL_REGISTER("isPendingZone", CLuaClientEntityPair::isPendingZone);
    SOL_REGISTER("getItemInvSlot", CLuaClientEntityPair::getItemInvSlot);
    SOL_REGISTER("claimAndKillMob", CLuaClientEntityPair::claimAndKillMob);
    SOL_REGISTER("claimAndKillMobs", CLuaClientEntityPair::claimAndKillMobs);
    SOL_READONLY("actions", CLuaClientEntityPair::actions);
    SOL_READONLY("bcnm", CLuaClientEntityPair::bcnm);
    SOL_READONLY("events", CLuaClientEntityPair::events);
    SOL_READONLY("entities", CLuaClientEntityPair::entities);
    SOL_READONLY("packets", CLuaClientEntityPair::packets);
}
