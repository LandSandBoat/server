-----------------------------------
-- Area: Upper Jeuno
--  NPC: Galmut's door
-- Starts and Finishes Quest: A Clock Most Delicate, Save the Clock Tower, The Clockmaster
-- !pos -80 0 104 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local aClockMostdelicate = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_CLOCK_MOST_DELICATE)

    if (aClockMostdelicate == QUEST_AVAILABLE and player:getCharVar("aClockMostdelicateVar") == 1) then
        player:startEvent(119) -- Start long cs quest with option "a clock most delicate"
    elseif (aClockMostdelicate == QUEST_AVAILABLE and player:getCharVar("aClockMostdelicateVar") == 2) then
        player:startEvent(118) -- Start short cs quest with option "a clock most delicate"
    elseif (aClockMostdelicate == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.CLOCK_TOWER_OIL) == true) then
            player:startEvent(202) -- Ending quest "a clock most delicate"
        else
            player:startEvent(117) -- During quest "a clock most delicate"
        end
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) == QUEST_COMPLETED and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_CLOCKMASTER) == QUEST_AVAILABLE) then
        player:startEvent(152) -- Start & finish quest "The Clockmaster"
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_CLOCKMASTER) == QUEST_COMPLETED) then
        player:startEvent(110) -- After quest "The Clockmaster"
    else
        player:startEvent(116) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 119 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.A_CLOCK_MOST_DELICATE)
        player:setCharVar("aClockMostdelicateVar", 0)
    elseif (csid == 119 and option == 0) then
        player:setCharVar("aClockMostdelicateVar", 2)
    elseif (csid == 118 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.A_CLOCK_MOST_DELICATE)
        player:setCharVar("aClockMostdelicateVar", 0)
    elseif (csid == 202) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12727)
        else
            player:addTitle(tpz.title.PROFESSIONAL_LOAFER)
            player:delKeyItem(tpz.ki.CLOCK_TOWER_OIL)
            player:addGil(1200)
            player:messageSpecial(ID.text.GIL_OBTAINED, 1200)
            player:addItem(12727)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12727)
            player:addFame(JEUNO, 30)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.A_CLOCK_MOST_DELICATE)
            player:addQuest(JEUNO, tpz.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) -- Start next quest "Save the Clock Tower"
        end
    elseif (csid == 152) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17083)
        else
            player:addQuest(JEUNO, tpz.quest.id.jeuno.THE_CLOCKMASTER)
            player:addTitle(tpz.title.TIMEKEEPER)
            player:addGil(1200)
            player:messageSpecial(ID.text.GIL_OBTAINED, 1200)
            player:addItem(17083)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17083)
            player:addFame(JEUNO, 30)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_CLOCKMASTER)
        end
    end
end
