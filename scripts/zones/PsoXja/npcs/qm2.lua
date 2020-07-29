-----------------------------------
-- Area: Pso'xja
--  NPC: ??? (qm2)
-- !pos -282.742 -3.600 -210.000 9
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
