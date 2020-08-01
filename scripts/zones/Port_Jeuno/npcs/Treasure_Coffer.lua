-----------------------------------
-- Area: Port Jeuno
--  NPC: Treasure Coffer
-- !pos  -52 0 -11 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:messageSpecial(ID.text.CHEST_IS_EMPTY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
