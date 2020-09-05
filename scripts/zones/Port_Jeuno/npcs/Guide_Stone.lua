-----------------------------------
-- Area: Port Jeuno
--  NPC: Guide Stone
-- !pos -149 -3 0 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:messageSpecial(ID.text.GUIDE_STONE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
