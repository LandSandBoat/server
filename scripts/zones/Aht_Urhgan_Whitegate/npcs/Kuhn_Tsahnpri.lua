-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kuhn Tsahnpri
-- !pos 12.08 2 143.39 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

local messages =
{
    [xi.transport.trigger.whitegate.FERRY_ARRIVING_FROM_NASHMAU] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.whitegate.FERRY_DEPARTING_TO_NASHMAU]  = ID.text.FERRY_DEPARTING
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:addPeriodicTrigger(xi.transport.trigger.whitegate.FERRY_ARRIVING_FROM_NASHMAU,
        xi.transport.interval.whitegate.FROM_TO_NASHMAU,
        xi.transport.offset.whitegate.FERRY_ARRIVING_FROM_NASHMAU)
    npc:addPeriodicTrigger(xi.transport.trigger.whitegate.FERRY_DEPARTING_TO_NASHMAU,
        xi.transport.interval.whitegate.FROM_TO_NASHMAU,
        xi.transport.offset.whitegate.FERRY_DEPARTING_TO_NASHMAU)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.transport.dockMessage(npc, triggerID, messages)
end

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, npc)
end

return entity
