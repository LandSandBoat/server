-----------------------------------
-- Area: Port Jeuno
--  NPC: Cumetouflaix
-- Standard NPC
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:messageSpecial(ID.text.CUMETOUFLAIX_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
