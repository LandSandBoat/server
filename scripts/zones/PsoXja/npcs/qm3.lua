-----------------------------------
-- Area: Pso'xja
--  NPC: ??? (qm3)
-- !pos -329.980 28.300 -163.000 9
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
