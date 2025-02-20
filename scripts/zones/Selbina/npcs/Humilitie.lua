-----------------------------------
-- Area: Selbina
--  NPC: Humilitie
-- Reports the time remaining before boat arrival.
-- !pos 17.979 -2.39 -58.800 248
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
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

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, npc)
end

return entity
