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
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_4") == 7 and npcUtil.tradeHas(trade, 1127) then -- Kindred Seal
        player:confirmTrade()
        player:setCharVar("ridingOnTheClouds_4", 0)
        npcUtil.giveKeyItem(player, xi.ki.SPIRITED_STONE)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
