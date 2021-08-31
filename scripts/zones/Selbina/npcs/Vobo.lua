-----------------------------------
-- Area: Selbina
--  NPC: Vobo
-- Involved in Quest: Riding on the Clouds
-- !pos 37 -14 81 248
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_3") == 2 and
        npcUtil.tradeHas(trade, 1127)
    then
        player:setCharVar("ridingOnTheClouds_3", 0)
        npcUtil.giveKeyItem(player, xi.ki.SOMBER_STONE)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(710)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
