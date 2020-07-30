-----------------------------------
-- Area: Windurst Woods
--  NPC: Sola Jaab
-- Involved in Quest: Riding on the Clouds
-- !pos 109 -5 -25 241
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_4") == 7 and npcUtil.tradeHas(trade, 1127) then -- Kindred Seal
        player:confirmTrade()
        player:setCharVar("ridingOnTheClouds_4", 0)
        npcUtil.giveKeyItem(player, tpz.ki.SPIRITED_STONE)
    end
end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
