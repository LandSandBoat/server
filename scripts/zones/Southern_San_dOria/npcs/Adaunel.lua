-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Adaunel
-- General Info NPC
-- !pos 80 -7 -22 230
------------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 13) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(656)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
