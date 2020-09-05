-----------------------------------
-- Area: Port Bastok
--  NPC: Klaus
-- Type: Standard NPC
-- !pos -89.355 -3.611 -15.256 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.KLAUS_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
