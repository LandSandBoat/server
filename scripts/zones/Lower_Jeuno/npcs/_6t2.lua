-----------------------------------
-- Area: Lower Jeuno
-- Door: Merchant's House
-- Starts & Finishes Quest: Save My Son
-- Optional Involvement in Quest: Chocobo's Wounds, Path of the Beastmaster
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local aNewDawn      = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
    local aNewDawnEvent = player:getCharVar("ANewDawn_Event")
    local saveMySon     = player:getCharVar("SaveMySon_Event")
    local mLvl          = player:getMainLvl()

    -- A New Dawn (BST AF3)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW) == QUEST_COMPLETED and
        aNewDawn == QUEST_AVAILABLE
    then
        if
            player:getMainJob() == xi.job.BST and
            mLvl >= 50
        then
            if aNewDawnEvent == 0 then
                player:startEvent(5)
            elseif aNewDawnEvent == 1 then
                player:startEvent(4)
            end
        else
            player:startEvent(1)
        end

    elseif aNewDawn == QUEST_ACCEPTED then
        if aNewDawnEvent == 2 then
            player:startEvent(2)
        elseif aNewDawnEvent >= 4 then
            player:startEvent(3)
        end

    elseif
        aNewDawn == QUEST_COMPLETED and
        aNewDawnEvent == 6
    then
        player:startEvent(0)

    -- Save My Son
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_AVAILABLE and
        mLvl >= 30
    then
        player:startEvent(164)

    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_ACCEPTED then
        if saveMySon == 0 then
            player:startEvent(229)
        elseif saveMySon == 1 then
            player:startEvent(163)
        end

    elseif
        not player:needToZone() and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON) == QUEST_COMPLETED and
        saveMySon == 2
    then
        player:startEvent(132)

    -- Standard Dialogue?, Probably Wrong
    else
        player:messageSpecial(ID.text.ITS_LOCKED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 164 and option == 0 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
    elseif csid == 163 then
        if player:getFreeSlotsCount(0) >= 1 then
            player:addTitle(xi.title.LIFE_SAVER)
            player:addItem(13110)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13110)
            npcUtil.giveCurrency(player, 'gil', 2100)
            player:setCharVar("SaveMySon_Event", 2)
            player:needToZone(true)
            player:addFame(xi.quest.fame_area.JEUNO, 30)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13110)
        end
    elseif csid == 132 then
        player:setCharVar("SaveMySon_Event", 0)
    elseif csid == 5 then
        player:setCharVar("ANewDawn_Event", 1)
        if option == 1 then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
            player:setCharVar("ANewDawn_Event", 2)
        end
    elseif csid == 4 and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
        player:setCharVar("ANewDawn_Event", 2)
    elseif csid == 0 then
        player:setCharVar("ANewDawn_Event", 0)
    end
end

return entity
