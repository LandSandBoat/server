-----------------------------------
-- Area: Silver_Sea_route_to_Al_Zahbi
--  NPC: Shadeeu
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 58
-----------------------------------
local ID = require("scripts/zones/Silver_Sea_route_to_Al_Zahbi/IDs")
require("scripts/globals/transport")
-----------------------------------

local messages =
{
    [tpz.transport.message.NEARING] = ID.text.NEARING_AL_ZAHBI,
    [tpz.transport.message.DOCKING] = ID.text.DOCKING_IN_AL_ZAHBI
}

function onSpawn(npc)
    npc:addPeriodicTrigger(tpz.transport.message.NEARING, tpz.transport.messageTime.SILVER_SEA, tpz.transport.epochOffset.NEARING)
    npc:addPeriodicTrigger(tpz.transport.message.DOCKING, tpz.transport.messageTime.SILVER_SEA, tpz.transport.epochOffset.DOCKING)
end

function onTimeTrigger(npc, triggerID)
    tpz.transport.captainMessage(npc, triggerID, messages)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.ON_WAY_TO_AL_ZAHBI, 0, 0) -- Earth Time, Vana Hours. Needs a get-time function for boat?
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
