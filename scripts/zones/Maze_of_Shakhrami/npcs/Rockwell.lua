-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Rockwell
-- Quest: Your Crystal Ball
-- !pos -18 -13 181 198
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL) == xi.questStatus.QUEST_ACCEPTED then
        if npcUtil.tradeHasExactly(trade, { { xi.item.AHRIMAN_LENS, 1 } }) then
            if player:getCharVar('QuestYourCrystalBall_prog') == 0 then
                player:confirmTrade()
                player:setCharVar('QuestYourCrystalBall_prog', os.time() + 30) -- current retail capture shows 30s time to pickup
                player:messageSpecial(ID.text.SUBMERGE, xi.item.AHRIMAN_LENS)
            else
                player:messageSpecial(ID.text.CANNOT_SUBMERGE, xi.item.AHRIMAN_LENS) -- don't initiate submerge if previous one hasn't been collected
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.YOUR_CRYSTAL_BALL) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('QuestYourCrystalBall_prog') ~= 0 -- if 0 then there is no currently submerged lens
    then
        if player:getCharVar('QuestYourCrystalBall_prog') < os.time() then
            player:startEvent(52):progress()
        else
            player:messageSpecial(ID.text.NOT_READY, 0, xi.item.DIVINATION_SPHERE):progress()
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 52 and npcUtil.giveItem(player, xi.item.DIVINATION_SPHERE) then
        player:setCharVar('QuestYourCrystalBall_prog', 0) -- set to 0 indicating divination sphere has been collected and no lens presently submerged
    end
end

return entity
