-----------------------------------
-- Area: Selbina
--  NPC: Mathilde
-- Involved in Quest: Riding on the Clouds
-- !pos 12.578 -8.287 -7.576 248
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and
        player:getCharVar("ridingOnTheClouds_3") == 1 and
        npcUtil.tradeHas(trade, 1127)
    then
        player:setCharVar("ridingOnTheClouds_3", 0)
        npcUtil.giveKeyItem(player, tpz.ki.SOMBER_STONE)
        player:confirmTrade()
    end

end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS and player:getCharVar("PromathiaStatus") == 2 then
        player:startEvent(10005)
    else
        player:startEvent(171)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10005 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.ONE_TO_BE_FEARED)
    end
end

return entity
