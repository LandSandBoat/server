-----------------------------------
-- Area: Mhaura
--  NPC: Dieh Yamilsiah
-- Reports the time remaining before boat arrival.
-- !pos 7.057 -2.364 2.489 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

local messages =
{
    [xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_ALZAHBI] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_ALZAHBI]  = ID.text.FERRY_DEPARTING,
    [xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_SELBINA] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_SELBINA]  = ID.text.FERRY_DEPARTING
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    -- TODO: NPC needs to rotate after finishing walking.
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_ALZAHBI,
        xi.transport.interval.mhaura.FROM_TO_ALZAHBI,
        xi.transport.offset.mhaura.FERRY_ARRIVING_FROM_ALZAHBI)
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_ALZAHBI,
        xi.transport.interval.mhaura.FROM_TO_ALZAHBI,
        xi.transport.offset.mhaura.FERRY_DEPARTING_TO_ALZAHBI)
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_SELBINA,
        xi.transport.interval.mhaura.FROM_TO_SELBINA,
        xi.transport.offset.mhaura.FERRY_ARRIVING_FROM_SELBINA)
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_SELBINA,
        xi.transport.interval.mhaura.FROM_TO_SELBINA,
        xi.transport.offset.mhaura.FERRY_DEPARTING_TO_SELBINA)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.transport.dockMessage(npc, triggerID, messages, 'mhaura')
end

entity.onTrigger = function(player, npc)
    xi.transport.onDockTimekeeperTrigger(player, npc)

    --[[Other cutscenes:
    233 "This ship is headed for Selbina."
    234 "The Selbina ferry will deparrrt soon!  Passengers are to board the ship immediately!"

    Can't find a way to toggle the destination on 233 or 234, so they are not used.
    Users knowing which ferry is which > using all CSs.]]
end

return entity
