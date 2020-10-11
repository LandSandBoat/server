-----------------------------------
-- Area: Upper Jeuno
--  NPC: Guide Stone
-- !pos 25 -3 -41 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
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
