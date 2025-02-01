-----------------------------------
-- Area: Lower Jeuno
--  NPC: Panta-Putta
-- Starts and Finishes Quest: The Wonder Magic Set, The kind cardian
-- Involved in Quests: The Lost Cardian
-- !pos -61 0 -140 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local theWonderMagicSet = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_WONDER_MAGIC_SET)
    local hasWonderMagicSet = player:hasKeyItem(xi.ki.WONDER_MAGIC_SET)
    local theKindCardian    = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN)

    if
        player:getFameLevel(xi.fameArea.JEUNO) >= 4 and
        theWonderMagicSet == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(77) -- Start quest "The wonder magic set"

    elseif
        theWonderMagicSet == xi.questStatus.QUEST_ACCEPTED and
        not hasWonderMagicSet
    then
        player:startEvent(55) -- During quest "The wonder magic set"

    elseif hasWonderMagicSet then
        player:startEvent(33) -- Finish quest "The wonder magic set"

    elseif
        theWonderMagicSet == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COOKS_PRIDE) ~= xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(40) -- Standard dialog

    elseif
        theWonderMagicSet == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN) == xi.questStatus.QUEST_AVAILABLE
    then
        if player:getCharVar('theLostCardianVar') >= 1 then
            player:startEvent(30) -- Second dialog for "The lost cardien" quest
        else
            player:startEvent(40) -- Standard dialog
        end

    elseif
        theKindCardian == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('theKindCardianVar') == 2
    then
        player:startEvent(35) -- Finish quest "The kind cardien"

    elseif theKindCardian == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(76) -- New standard dialog after "The kind cardien"

    else
        player:startEvent(78) -- Base standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 77 and option == 1 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_WONDER_MAGIC_SET)
    elseif csid == 33 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MYTHRIL_EARRING)
        else
            player:addTitle(xi.title.FOOLS_ERRAND_RUNNER)
            player:delKeyItem(xi.ki.WONDER_MAGIC_SET)
            player:addItem(xi.item.MYTHRIL_EARRING)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MYTHRIL_EARRING)
            player:addFame(xi.fameArea.JEUNO, 30)
            player:needToZone(true)
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_WONDER_MAGIC_SET)
        end
    elseif csid == 30 then
        player:setCharVar('theLostCardianVar', 2)
    elseif csid == 35 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.GREEN_CAPE)
        else
            player:addTitle(xi.title.BRINGER_OF_BLISS)
            player:delKeyItem(xi.ki.TWO_OF_SWORDS)
            player:setCharVar('theKindCardianVar', 0)
            player:addItem(xi.item.GREEN_CAPE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.GREEN_CAPE) -- Green Cape
            player:addFame(xi.fameArea.JEUNO, 30)
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN)
        end
    end
end

return entity
