-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Baya Hiramayuh
-- !pos -12.08 2 -143.37 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

local messages =
{
    [xi.transport.trigger.whitegate.FERRY_ARRIVING_FROM_MHAURA] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.whitegate.FERRY_DEPARTING_TO_MHAURA]  = ID.text.FERRY_DEPARTING
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:addPeriodicTrigger(xi.transport.trigger.whitegate.FERRY_ARRIVING_FROM_MHAURA,
        xi.transport.interval.whitegate.FROM_TO_MHAURA,
        xi.transport.offset.whitegate.FERRY_ARRIVING_FROM_MHAURA)
    npc:addPeriodicTrigger(xi.transport.trigger.whitegate.FERRY_DEPARTING_TO_MHAURA,
        xi.transport.interval.whitegate.FROM_TO_MHAURA,
        xi.transport.offset.whitegate.FERRY_DEPARTING_TO_MHAURA)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.transport.dockMessage(npc, triggerID, messages)
end

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, npc)
end

return entity
