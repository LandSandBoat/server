-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Rockwell
-- Quest: Your Crystal Ball
-- !pos -18 -13 181 198
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL) == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.AHRIMAN_LENS)
    then
        player:setCharVar('QuestYourCrystalBall_prog', 1)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('QuestYourCrystalBall_prog') == 1
    then
        player:startEvent(52)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 52 and npcUtil.giveItem(player, xi.item.DIVINATION_SPHERE) then
        player:setCharVar('QuestYourCrystalBall_prog', 0)
    end
end

return entity
