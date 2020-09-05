-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Villion
-- Type: Adventurer's Assistant NPC
--  Involved in Quest: Flyers for Regine
-- !pos -157.524 4.000 263.818 231
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 9) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(632)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
