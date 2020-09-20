-----------------------------------
-- Area: Lower Jeuno
--  NPC: Guide Stone
-- !pos  19 -3 47 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
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
