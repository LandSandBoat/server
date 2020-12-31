-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nonterene
-- Type: Adventurer's Assistant NPC
-- !pos -6.347 0.000 -11.265 231
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.EXIT_THE_GAMBLER) == QUEST_ACCEPTED then
        player:startEvent(523)
    else
        player:startEvent(503)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
