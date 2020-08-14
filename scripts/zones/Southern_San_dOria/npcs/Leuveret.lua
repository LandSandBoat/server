-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Leuveret
-- Type: General Info NPC
-------------------------------------
require("scripts/quests/flyers_for_regine")
-------------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 14) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(621)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
