-----------------------------------
-- Area: Silver_Sea_route_to_Nashmau
--  NPC: Qudamahf
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 58
-----------------------------------
local ID = zones[xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

local messages =
{
    [xi.transport.message.NEARING] = ID.text.NEARING_NASHMAU,
    [xi.transport.message.DOCKING] = ID.text.DOCKING_IN_NASHMAU
}

entity.onSpawn = function(npc)
    npc:addPeriodicTrigger(xi.transport.message.NEARING, xi.transport.messageTime.SILVER_SEA, xi.transport.epochOffset.NEARING)
    npc:addPeriodicTrigger(xi.transport.message.DOCKING, xi.transport.messageTime.SILVER_SEA, xi.transport.epochOffset.DOCKING)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.transport.captainMessage(npc, triggerID, messages)
end

entity.onTrigger = function(player, npc)
    xi.transport.onBoatTimekeeperTrigger(player, xi.transport.routes.SILVER_SEA, ID.text.ON_WAY_TO_NASHMAU, ID.text.ARRIVING_SOON_NASHMAU)
end

return entity
