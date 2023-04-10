-----------------------------------
-- Area: Selbina
--  NPC: Humilitie
-- Reports the time remaining before boat arrival.
-- !pos 17.979 -2.39 -58.800 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/transport")
-----------------------------------
local entity = {}

local messages =
{
    [xi.transport.trigger.selbina.FERRY_ARRIVING_FROM_MHAURA] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.selbina.FERRY_DEPARTING_TO_MHAURA]  = ID.text.FERRY_DEPARTING
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:addPeriodicTrigger(xi.transport.trigger.selbina.FERRY_ARRIVING_FROM_MHAURA,
        xi.transport.interval.selbina.FROM_TO_MHAURA,
        xi.transport.offset.selbina.FERRY_ARRIVING_FROM_MHAURA)
    npc:addPeriodicTrigger(xi.transport.trigger.selbina.FERRY_DEPARTING_TO_MHAURA,
        xi.transport.interval.selbina.FROM_TO_MHAURA,
        xi.transport.offset.selbina.FERRY_DEPARTING_TO_MHAURA)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.transport.dockMessage(npc, triggerID, messages, 'selbina')
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Based on scripts/zones/Mhaura/Dieh_Yamilsiah.lua
    local timer = 1152 - ((os.time() - 1009810800) % 1152)
    local direction = 0 -- Arrive, 1 for depart
    local waiting = 216 -- Offset for Mhaura

    if timer <= waiting then
        direction = 1 -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    player:startEvent(231, timer, direction)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
