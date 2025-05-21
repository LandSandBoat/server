-----------------------------------
-- Area: Upper Jeuno
--  NPC: Ilumida
-- Starts and Finishes Quest: A Candlelight Vigil
-- !pos -75 -1 58 244
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local searchingForWords = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)

    --this variable implicitly stores: JFame >= 7 and ACandlelightVigil == xi.questStatus.QUEST_COMPLETED and RubbishDay == xi.questStatus.QUEST_COMPLETED and
    --NeverToReturn == xi.questStatus.QUEST_COMPLETED and SearchingForTheRightWords == xi.questStatus.QUEST_AVAILABLE and prereq CS complete
    local searchingForWordsPrereq = player:getCharVar('QuestSearchRightWords_prereq')

    if searchingForWordsPrereq == 1 then --has player completed prerequisite cutscene with Kurou-Morou?
        player:startEvent(197) --SearchingForTheRightWords intro CS

    elseif player:getCharVar('QuestSearchRightWords_denied') == 1 then
        player:startEvent(201) --asks player again, SearchingForTheRightWords accept/deny

    elseif searchingForWords == xi.questStatus.QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.MOONDROP) then
            player:startEvent(198)
        else
            player:startEvent(199) -- SearchingForTheRightWords quest accepted dialog
        end

    elseif player:getCharVar('SearchingForRightWords_postcs') == -1 then
        player:startEvent(196)

    elseif searchingForWords == xi.questStatus.QUEST_COMPLETED then -- replaceDefault()
        player:startEvent(200)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 197 and option == 0 then --quest denied, special eventIDs available
        player:setCharVar('QuestSearchRightWords_prereq', 0) --remove charVar from memory
        player:setCharVar('QuestSearchRightWords_denied', 1)

    elseif
        (csid == 197 and option == 1) or
        (csid == 201 and option == 1)
    then
        player:setCharVar('QuestSearchRightWords_prereq', 0) --remove charVar from memory
        player:setCharVar('QuestSearchRightWords_denied', 0)
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)

    elseif csid == 198 then --finish quest, note: no title granted
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.SCROLL_OF_SLEEPGA_II)
        else
            player:delKeyItem(xi.ki.MOONDROP)
            npcUtil.giveCurrency(player, 'gil', 3000)
            player:addItem(xi.item.SCROLL_OF_SLEEPGA_II)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_SLEEPGA_II)
            player:addFame(xi.fameArea.JEUNO, 30)
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)
            player:setCharVar('SearchingForRightWords_postcs', -2)
        end
    elseif csid == 196 then
        player:setCharVar('SearchingForRightWords_postcs', 0)
    end
end

return entity
