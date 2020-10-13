-----------------------------------
-- Area: Port San d'Oria
--  NPC: Auvare
-- Standard Info NPC
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 4) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(598)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
