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

#include "lua/helpers/lua_client_entity_pair_events.h"

#include "common/logging.h"
#include "common/lua.h"
#include "enums/packet_c2s.h"
#include "lua/helpers/lua_client_entity_pair_packets.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "lua/sol_bindings.h"
#include "map/entities/charentity.h"
#include "map/packets/c2s/0x05b_eventend.h"
#include "packets/basic.h"
#include "test_char.h"
#include "test_common.h"

CLuaClientEntityPairEvents::CLuaClientEntityPairEvents(CLuaClientEntityPair* parent)
: parent_(parent)
{
}

void CLuaClientEntityPairEvents::sendEventPacket(sol::optional<uint16> eventId, const sol::optional<uint32> option, const bool isUpdate) const
{
    const uint16 actualEventId = eventId.value_or(currentId());

    if (actualEventId == 65535)
    {
        if (eventId.has_value())
        {
            TestError("Not currently in an event, expected: {}", eventId.value());
        }
        else
        {
            TestError("Not currently in an event");
        }

        return;
    }

    if (eventId.has_value() && eventId.value() != currentId())
    {
        TestError("Expected event {}, but current event is {}",
                  eventId.value(), currentId());
        return;
    }

    const auto packet      = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_EVENTEND);
    auto*      eventPacket = packet->as<GP_CLI_COMMAND_EVENTEND>();

    eventPacket->EndPara   = option.value_or(0);
    eventPacket->Mode      = isUpdate ? static_cast<uint16_t>(GP_CLI_COMMAND_EVENTEND_MODE::UpdatePending)
                                      : static_cast<uint16_t>(GP_CLI_COMMAND_EVENTEND_MODE::End);
    eventPacket->EventPara = actualEventId;

    parent_->packets().sendBasicPacket(*packet);
    parent_->packets().parseIncoming();
}

/************************************************************************
 *  Function: finish()
 *  Purpose : Expect and handle an event with finish option.
 *  Example : player.events:finish(123, 1)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairEvents::finish(const sol::optional<uint16> eventId, const sol::optional<uint32> option) const
{
    ShowInfoFmt("Sending event finish packet for event ID: {}", eventId.value_or(currentId()));
    sendEventPacket(eventId, option, false);
}

/************************************************************************
 *  Function: update()
 *  Purpose : Expect and handle an event with update option.
 *  Example : player.events:update(123, 1)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairEvents::update(const sol::optional<uint16> eventId, const sol::optional<uint32> option) const
{
    ShowInfoFmt("Sending event update packet for event ID: {}", eventId.value_or(currentId()));
    sendEventPacket(eventId, option, true);
}

/************************************************************************
 *  Function: expectNotInEvent()
 *  Purpose : Expect to not be in an event.
 *  Example : player.events:expectNotInEvent()
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairEvents::expectNotInEvent() const
{
    if (uint16 currentEventId = currentId(); currentEventId != 65535)
    {
        TestError("Currently in event: {}", currentEventId);
    }
}

/************************************************************************
 *  Function: expect()
 *  Purpose : Expect and handle an event with optional updates and finish option.
 *  Example : player.events:expect({ eventId = 123, updates = {1,2}, finishOption = 0 })
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairEvents::expect(sol::table expectedEvent) const
{
    const sol::optional<uint16> eventId      = expectedEvent["eventId"];
    sol::optional<sol::table>   updates      = expectedEvent["updates"];
    const sol::optional<uint32> finishOption = expectedEvent["finishOption"];

    if (updates.has_value())
    {
        const sol::table updateTable = updates.value();
        for (const auto& pair : updateTable)
        {
            if (pair.second.is<uint32>())
            {
                uint32 updateOption = pair.second.as<uint32>();
                DebugTestFmt("Sending event update with option: {}", updateOption);
                update(eventId, updateOption);
            }
        }
    }

    DebugTestFmt("Sending event finish with option: {}", finishOption.value_or(0));
    finish(eventId, finishOption);

    if (parent_->isPendingZone())
    {
        if (const CLuaSimulation* simulation = parent_->simulation())
        {
            simulation->tick();
        }

        parent_->packets().parseIncoming();
    }
}

auto CLuaClientEntityPairEvents::currentId() const -> uint16
{
    return parent_->testChar()->entity()->currentEvent->eventId;
}

void CLuaClientEntityPairEvents::Register()
{
    SOL_USERTYPE("CClientEntityPairEvents", CLuaClientEntityPairEvents);
    SOL_REGISTER("finish", CLuaClientEntityPairEvents::finish);
    SOL_REGISTER("update", CLuaClientEntityPairEvents::update);
    SOL_REGISTER("expectNotInEvent", CLuaClientEntityPairEvents::expectNotInEvent);
    SOL_REGISTER("expect", CLuaClientEntityPairEvents::expect);
}
