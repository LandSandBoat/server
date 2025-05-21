-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vola
-- Starts and Finishes Quest: Fistful of Fury
-- Involved in Quests: Beat Around the Bushin (before the quest)
-- !pos 43 3 -45 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.FISTFUL_OF_FURY) == xi.questStatus.QUEST_ACCEPTED and
        trade:hasItemQty(xi.item.NUE_FANG, 1) and
        trade:hasItemQty(xi.item.MORBOLGER_VINE, 1) and
        trade:hasItemQty(xi.item.DODO_SKIN, 1) and
        trade:getItemCount() == 3
    then
        player:startEvent(213) -- Finish Quest "Fistful of Fury"
    end
end

entity.onTrigger = function(player, npc)
    local fistfulOfFury = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.FISTFUL_OF_FURY)
    local beatAroundTheBushin = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN)

    if
        player:getFameLevel(xi.fameArea.NORG) >= 3 and
        fistfulOfFury == xi.questStatus.QUEST_AVAILABLE and
        player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.SILENCE_OF_THE_RAMS) == xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(216) -- Start Quest "Fistful of Fury"

    elseif fistfulOfFury == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(215) -- During Quest "Fistful of Fury"

    elseif
        beatAroundTheBushin == xi.questStatus.QUEST_AVAILABLE and
        player:getMainJob() == xi.job.MNK and
        player:getMainLvl() >= 71 and
        player:getFameLevel(xi.fameArea.NORG) >= 6
    then
        player:startEvent(160) -- Start Quest "Beat Around the Bushin"

    elseif beatAroundTheBushin ~= xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(214) -- During & After Quest "Beat Around the Bushin"

    else
        player:startEvent(212) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 216 and option == 1 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.FISTFUL_OF_FURY)

    elseif csid == 213 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.BROWN_BELT)
        else
            player:addTitle(xi.title.BROWN_BELT)
            player:addItem(xi.item.BROWN_BELT)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.BROWN_BELT)
            player:addFame(xi.fameArea.NORG, 125)
            player:tradeComplete()
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.FISTFUL_OF_FURY)
        end

    elseif
        csid == 160 and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN) == xi.questStatus.QUEST_AVAILABLE
    then
        player:setCharVar('BeatAroundTheBushin', 1) -- For the next quest "Beat around the Bushin"
    end
end

return entity
