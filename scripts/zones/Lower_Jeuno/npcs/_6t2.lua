-----------------------------------
-- Area: Lower Jeuno
-- Door: Merchant's House
-- Starts & Finishes Quest: Save My Son
-- Optional Involvement in Quest: Chocobo's Wounds, Path of the Beastmaster
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local aNewDawn      = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)
    local aNewDawnEvent = player:getCharVar("ANewDawn_Event")
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
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 5 then
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
