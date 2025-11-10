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

#include "lua/helpers/lua_client_entity_pair_bcnm.h"
#include "common/logging.h"
#include "lua/helpers/lua_client_entity_pair_actions.h"
#include "lua/helpers/lua_client_entity_pair_entities.h"
#include "lua/helpers/lua_client_entity_pair_events.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "map/battlefield.h"
#include "map/entities/mobentity.h"
#include "test_char.h"
#include "test_common.h"

CLuaClientEntityPairBCNM::CLuaClientEntityPairBCNM(CLuaClientEntityPair* parent)
: parent_{ parent }
{
}

/************************************************************************
 *  Function: killMobs()
 *  Purpose : Kill all mobs in the current battlefield
 *  Example : client.bcnm:killMobs({expectDeath = true})
 *  Notes   : Iterates through all battlefield mobs and kills them
 ************************************************************************/

void CLuaClientEntityPairBCNM::killMobs(const sol::optional<sol::table>& params) const
{
    const auto battlefield = parent_->getBattlefield();
    if (!battlefield)
    {
        TestError("Player not currently in a battlefield");
        return;
    }

    // Kill each spawned mob in the battlefield

    battlefield->ForEachEnemy(
        [this, params](CMobEntity* mobEntity)
        {
            if (mobEntity && mobEntity->isAlive())
            {
                CLuaTestEntity mobWrapper(mobEntity);

                const sol::object mobObj = sol::make_object(lua.lua_state(), &mobWrapper);
                parent_->claimAndKillMob(mobObj, params);
            }
        });
}

/************************************************************************
 *  Function: expectWin()
 *  Purpose : Expect a BCNM win event
 *  Example : client.bcnm:expectWin({delayedWin = true, finishOption = 1})
 *  Notes   : Handles delayed wins and event completion
 ************************************************************************/

void CLuaClientEntityPairBCNM::expectWin(sol::optional<sol::table> params) const
{
    bool                  delayedWin   = true;
    sol::optional<uint32> finishOption = sol::nullopt;

    // Parse parameters if provided
    if (params.has_value())
    {
        sol::table paramTable = params.value();
        delayedWin            = paramTable["delayedWin"].get_or(true);
        finishOption          = paramTable["finishOption"].get_or(sol::optional<uint32>(sol::nullopt));
    }

    parent_->simulation()->tick();

    if (delayedWin)
    {
        parent_->simulation()->skipTime(7);
    }

    const auto eventTable = lua.create_table_with(
        "eventId", 32001, "finishOption", finishOption.value_or(0));
    parent_->events().expect(eventTable);
}

/************************************************************************
 *  Function: enter()
 *  Purpose : Enter a BCNM via NPC interaction
 *  Example : client.bcnm:enter("Shami", 1, {xi.item.CLOUDY_ORB})
 *  Notes   : Looks up BCNM info and handles trade or trigger
 ************************************************************************/

void CLuaClientEntityPairBCNM::enter(const sol::object& npcQuery, const uint16 bcnmId, sol::optional<sol::table> items) const
{
    const uint16 zoneId = parent_->getZoneID();

    sol::table                contentsByZone = lua["xi"]["battlefield"]["contentsByZone"];
    sol::optional<sol::table> zoneContent    = contentsByZone[zoneId];

    if (!zoneContent.has_value())
    {
        TestError("No BCNM content defined for zone {}", zoneId);
        return;
    }

    // Find the BCNM info
    uint16 bcnmIndex = 0;
    bool   found     = false;

    // Iterate through the battlefield contents
    for (const auto& [key, value] : zoneContent.value())
    {
        if (value.is<sol::table>())
        {
            auto battleContent = value.as<sol::table>();

            if (auto battlefieldId = battleContent["battlefieldId"]; battlefieldId.valid())
            {
                if (battlefieldId.get<uint16>() == bcnmId)
                {
                    if (auto index = battleContent["index"]; index.valid() && index.is<uint16>())
                    {
                        bcnmIndex = index.get<uint16>();
                        found     = true;
                        break;
                    }
                }
            }
        }
    }

    if (!found)
    {
        TestError("BCNM {} not found in zone {}", bcnmId, zoneId);
        return;
    }

    // Calculate option value
    uint32     option        = (bcnmIndex << 4) + 1;
    sol::table expectedEvent = sol::state_view(lua.lua_state()).create_table();
    expectedEvent["eventId"] = 32000;
    sol::table updates       = sol::state_view(lua.lua_state()).create_table();
    updates[1]               = option;
    expectedEvent["updates"] = updates;

    // Either trade items or trigger the NPC
    if (items.has_value())
    {
        parent_->actions().tradeNpc(npcQuery, items.value(), expectedEvent);
    }
    else
    {
        std::ignore = parent_->entities().gotoAndTrigger(npcQuery, expectedEvent);
    }

    if (!parent_->hasStatusEffect(EFFECT_BATTLEFIELD, sol::lua_nil))
    {
        TestError("Battlefield effect not found.");
        return;
    }

    if (parent_->getLocalVar("battlefieldID") != bcnmId)
    {
        TestError("Wrong or missing battlefieldID.");
    }

    if (const auto battlefield = parent_->getBattlefield())
    {
        ShowInfoFmt("Entered BCNM: {} in zone {} (area {})",
                    battlefield->GetName(),
                    zoneId,
                    battlefield->GetArea());
    }
}

void CLuaClientEntityPairBCNM::Register()
{
    SOL_USERTYPE("CClientEntityPairBCNM", CLuaClientEntityPairBCNM);
    SOL_REGISTER("killMobs", CLuaClientEntityPairBCNM::killMobs);
    SOL_REGISTER("expectWin", CLuaClientEntityPairBCNM::expectWin);
    SOL_REGISTER("enter", CLuaClientEntityPairBCNM::enter);
}
