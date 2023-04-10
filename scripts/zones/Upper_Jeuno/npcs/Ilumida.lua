-----------------------------------
-- Area: Upper Jeuno
--  NPC: Ilumida
-- Starts and Finishes Quest: A Candlelight Vigil
-- !pos -75 -1 58 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local searchingForWords = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)

    --this variable implicitly stores: JFame >= 7 and ACandlelightVigil == QUEST_COMPLETED and RubbishDay == QUEST_COMPLETED and
    --NeverToReturn == QUEST_COMPLETED and SearchingForTheRightWords == QUEST_AVAILABLE and prereq CS complete
    local searchingForWordsPrereq = player:getCharVar("QuestSearchRightWords_prereq")

    if searchingForWordsPrereq == 1 then --has player completed prerequisite cutscene with Kurou-Morou?
        player:startEvent(197) --SearchingForTheRightWords intro CS

    elseif player:getCharVar("QuestSearchRightWords_denied") == 1 then
        player:startEvent(201) --asks player again, SearchingForTheRightWords accept/deny

    elseif searchingForWords == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.MOONDROP) then
            player:startEvent(198)
        else
            player:startEvent(199) -- SearchingForTheRightWords quest accepted dialog
        end

    elseif player:getCharVar("SearchingForRightWords_postcs") == -1 then
        player:startEvent(196)

    elseif searchingForWords == QUEST_COMPLETED then -- replaceDefault()
        player:startEvent(200)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 197 and option == 0 then --quest denied, special eventIDs available
        player:setCharVar("QuestSearchRightWords_prereq", 0) --remove charVar from memory
        player:setCharVar("QuestSearchRightWords_denied", 1)

    elseif
        (csid == 197 and option == 1) or
        (csid == 201 and option == 1)
    then
        player:setCharVar("QuestSearchRightWords_prereq", 0) --remove charVar from memory
        player:setCharVar("QuestSearchRightWords_denied", 0)
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)

    elseif csid == 198 then --finish quest, note: no title granted
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4882)
        else
            player:delKeyItem(xi.ki.MOONDROP)
            npcUtil.giveCurrency(player, 'gil', 3000)
            player:addItem(4882)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4882)
            player:addFame(xi.quest.fame_area.JEUNO, 30)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS)
            player:setCharVar("SearchingForRightWords_postcs", -2)
        end
    elseif csid == 196 then
        player:setCharVar("SearchingForRightWords_postcs", 0)
    end
end

return entity
