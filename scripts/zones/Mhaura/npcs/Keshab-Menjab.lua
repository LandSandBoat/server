-----------------------------------
-- Area: Mhaura
--  NPC: Keshab-Menjab
-- Type: Standard NPC
-- !pos -15.727 -9.032 54.049 249
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(313)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
