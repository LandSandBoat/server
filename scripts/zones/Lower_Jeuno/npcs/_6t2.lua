-----------------------------------
-- Area: Lower Jeuno
--  Door: Merchant's House
--  Starts & Finishes Quest: Save My Son
--  Optional Involvement in Quest: Chocobo's Wounds, Path of the Beastmaster
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ANewDawn = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
    local ANewDawnEvent = player:getCharVar("ANewDawn_Event")
    local ScatteredIntoShadow = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
    local SaveMySon = player:getCharVar("SaveMySon_Event")

    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    -- A New Dawn (BST AF3)
    if (ScatteredIntoShadow == QUEST_COMPLETED and ANewDawn == QUEST_AVAILABLE) then
        if (mJob == xi.job.BST and mLvl >= 50) then
            if (ANewDawnEvent == 0) then
                player:startEvent(5)
            elseif (ANewDawnEvent == 1) then
                player:startEvent(4)
            end
        else
            player:startEvent(1)
        end
    elseif (ANewDawn == QUEST_ACCEPTED) then
        if (ANewDawnEvent == 2) then
            player:startEvent(2)
        elseif (ANewDawnEvent >= 4) then
            player:startEvent(3)
        end
    elseif (ANewDawn == QUEST_COMPLETED and ANewDawnEvent == 6) then
        player:startEvent(0)

    -- Save My Son
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_AVAILABLE and mLvl >= 30) then
        player:startEvent(164)
    elseif (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_ACCEPTED) then
        if (SaveMySon == 0) then
            player:startEvent(229)
        elseif (SaveMySon == 1) then
            player:startEvent(163)
        end
    elseif (player:needToZone() == false and player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_COMPLETED and SaveMySon == 2) then
        player:startEvent(132)

    -- Standard Dialogue?, Probably Wrong
    else
        player:messageSpecial(ID.text.ITS_LOCKED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 164 and option == 0) then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
    elseif (csid == 163) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addTitle(xi.title.LIFE_SAVER)
            player:addItem(13110)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13110)
            player:addGil(xi.settings.GIL_RATE * 2100)
            player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 2100)
            player:setCharVar("SaveMySon_Event", 2)
            player:needToZone(true)
            player:addFame(JEUNO, 30)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13110)
        end
    elseif (csid == 132) then
        player:setCharVar("SaveMySon_Event", 0)
    elseif (csid == 5) then
        player:setCharVar("ANewDawn_Event", 1)
        if (option == 1) then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
            player:setCharVar("ANewDawn_Event", 2)
        end
    elseif (csid == 4 and option == 1) then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
        player:setCharVar("ANewDawn_Event", 2)
    elseif (csid == 0) then
        player:setCharVar("ANewDawn_Event", 0)
    end
end

return entity
