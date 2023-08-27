-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Rockwell
-- Quest: Your Crystal Ball
-- !pos -18 -13 181 198
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.items.AHRIMAN_LENS)
    then
        if player:getCharVar("QuestYourCrystalBall_prog") > os.time() then
            player:messageSpecial(ID.text.CANNOT_SUBMERGE)
        else
            player:setCharVar("QuestYourCrystalBall_prog", getMidnight())
            player:confirmTrade(trade)
            player:messageSpecial(ID.text.SUBMERGE)
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL) == QUEST_ACCEPTED and
        player:getCharVar("QuestYourCrystalBall_prog") < os.time() and
        not player:hasItem(xi.items.DIVINATION_SPHERE)
    then
        player:startEvent(52)
    elseif player:getCharVar("QuestYourCrystalBall_prog") > os.time() then
        player:messageSpecial(ID.text.NOT_READY, xi.items.DIVINATION_SPHERE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 52 then
        npcUtil.giveItem(player, xi.items.DIVINATION_SPHERE)
    end
end

return entity
