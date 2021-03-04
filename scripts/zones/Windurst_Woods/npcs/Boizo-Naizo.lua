-----------------------------------
-- Area: Windurst Woods
--  NPC: Boizo-Naizo
-- Involved in Quest: Riding on the Clouds
-- !pos -9.581 -3.75 -26.062 241
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_4") == 6 and
        npcUtil.tradeHas(trade, 1127)
    then
        player:setCharVar("ridingOnTheClouds_4", 0)
        player:confirmTrade()
        npcUtil.giveKeyItem(player, tpz.ki.SPIRITED_STONE)
    end
end

entity.onTrigger = function(player, npc)
    local allNewC2000 = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_ALL_NEW_C_2000)
    local greetingCardian = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.A_GREETING_CARDIAN)

    if allNewC2000 == QUEST_ACCEPTED then
        player:startEvent(290)
    elseif greetingCardian == QUEST_COMPLETED then
        player:startEvent(307)
    else
        player:startEvent(275)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
