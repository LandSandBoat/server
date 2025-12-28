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

#include "lua/helpers/lua_client_entity_pair_entities.h"

#include "common/logging.h"
#include "common/lua.h"
#include "lua/helpers/lua_client_entity_pair_actions.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_test_entity.h"
#include "map/lua/lua_baseentity.h"
#include "map/utils/zoneutils.h"
#include "map/zone.h"
#include "test_char.h"
#include "test_common.h"

CLuaClientEntityPairEntities::CLuaClientEntityPairEntities(CLuaClientEntityPair* parent)
: parent_(parent)
{
}

/************************************************************************
 *  Function: get()
 *  Purpose : Retrieve non-PC entity matching query.
 *  Example : player.entities:get(12345)
 *            player.entities:get("Fafnir")
 *  Notes   : Use in place of other global entity lookup functions.
 *            Returned entity is wired up for assertions.
 ************************************************************************/

auto CLuaClientEntityPairEntities::get(const sol::object& entityQuery) const -> std::optional<CLuaTestEntity>
{
    switch (entityQuery.get_type())
    {
        case sol::type::number:
        {
            auto       entityId = entityQuery.as<uint32>();
            const auto entity   = zoneutils::GetEntity(entityId, TYPE_MOB | TYPE_PET | TYPE_NPC);

            if (!entity)
            {
                TestError("Entity with ID {} not found", entityId);
                return std::nullopt;
            }

            return CLuaTestEntity(entity);
        }
        case sol::type::string:
        {
            auto entityName = entityQuery.as<std::string>();

            CZone* zone = zoneutils::GetZone(parent_->getZoneID());

            if (!zone)
            {
                TestError("Current zone not found");
                return std::nullopt;
            }

            const auto results = zone->queryEntitiesByName(entityName);

            if (results.empty())
            {
                TestError("Entity '{}' not found in current zone", entityName);
                return std::nullopt;
            }

            return CLuaTestEntity(results[0]);
        }
        case sol::type::userdata:
        {
            // Try to convert from CLuaTestEntity or CLuaClientEntityPair
            if (entityQuery.is<CLuaTestEntity>())
            {
                return entityQuery.as<CLuaTestEntity>();
            }

            return std::nullopt;
        }
        default:
        {
            TestError("Invalid entity query type - expected ID (number), name (string), or entity object");
            return std::nullopt;
        }
    }
}

/************************************************************************
 *  Function: moveTo()
 *  Purpose : Moves to non-PC entity matching query.
 *  Example : player.entities:moveTo(12345)
 *            player.entities:moveTo('Fafnir')
 *  Notes   : Returned entity is wired up for assertions.
 ************************************************************************/

auto CLuaClientEntityPairEntities::moveTo(const sol::object& entityQuery) const -> std::optional<CLuaTestEntity>
{
    const auto entity = get(entityQuery);

    if (entity.has_value())
    {
        if (const CBaseEntity* baseEntity = entity.value().GetBaseEntity())
        {
            // Move the player to the entity
            const auto playerEntity = parent_->testChar()->entity();
            playerEntity->loc.p     = baseEntity->loc.p;

            // Force refresh of spawn lists, as if we had moved there manually.
            playerEntity->loc.zone->SpawnNPCs(playerEntity);
            playerEntity->loc.zone->SpawnMOBs(playerEntity);
            playerEntity->loc.zone->SpawnPETs(playerEntity);
            playerEntity->loc.zone->SpawnTRUSTs(playerEntity);
        }
    }

    return entity;
}

/************************************************************************
 *  Function: gotoAndTrigger()
 *  Purpose : Moves to non-PC entity matching query and emits trigger action.
 *  Example : player.entities:gotoAndTrigger(12345)
 *  Notes   : Can optionally expect a specific event to be triggered.
 ************************************************************************/

auto CLuaClientEntityPairEntities::gotoAndTrigger(const sol::object& entityQuery, const sol::optional<sol::table>& expectedEvent) const -> std::optional<CLuaTestEntity>
{
    auto entity = moveTo(entityQuery);

    if (entity.has_value())
    {
        parent_->actions().trigger(&entity.value(), expectedEvent);
    }

    return entity;
}

void CLuaClientEntityPairEntities::Register()
{
    SOL_USERTYPE("CClientEntityPairEntities", CLuaClientEntityPairEntities);
    SOL_REGISTER("get", CLuaClientEntityPairEntities::get);
    SOL_REGISTER("moveTo", CLuaClientEntityPairEntities::moveTo);
    SOL_REGISTER("gotoAndTrigger", CLuaClientEntityPairEntities::gotoAndTrigger);
}
