-----------------------------------
-- Area: Silver_Sea_route_to_Nashmau
--  NPC: Qudamahf
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 58
-----------------------------------
local ID = require("scripts/zones/Silver_Sea_route_to_Nashmau/IDs")
require("scripts/globals/transport")
-----------------------------------
local entity = {}

local messages =
{
    [tpz.transport.message.NEARING] = ID.text.NEARING_NASHMAU,
    [tpz.transport.message.DOCKING] = ID.text.DOCKING_IN_NASHMAU
}

entity.onSpawn = function(npc)
    npc:addPeriodicTrigger(tpz.transport.message.NEARING, tpz.transport.messageTime.SILVER_SEA, tpz.transport.epochOffset.NEARING)
    npc:addPeriodicTrigger(tpz.transport.message.DOCKING, tpz.transport.messageTime.SILVER_SEA, tpz.transport.epochOffset.DOCKING)
end

entity.onTimeTrigger = function(npc, triggerID)
    tpz.transport.captainMessage(npc, triggerID, messages)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.ON_WAY_TO_NASHMAU, 0, 0) -- Earth Time, Vana Hours. Needs a get-time function for boat?
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
