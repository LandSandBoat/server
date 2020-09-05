-----------------------------------
-- Area: Port San d'Oria
--  NPC: Portaure
-- Standard Info NPC
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 3) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(651)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
