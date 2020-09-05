-----------------------------------
-- Area: Port San d'Oria
--  NPC: Prietta
-- Standard Info NPC
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 1) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(596)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
