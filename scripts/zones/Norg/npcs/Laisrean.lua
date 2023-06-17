-----------------------------------
-- Area: Norg
--  NPC: Laisrean
-- Starts and Ends Quest: The Sahagin's Stash
-- !pos -2.251 -1 21.654 252
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stash = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SAHAGINS_STASH)
    local mLvl = player:getMainLvl()

    if
        stash == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.NORG) >= 4 and
        mLvl >= 5
    then
        player:startEvent(33) -- Start quest
    elseif stash == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SEA_SERPENT_STATUE) then
            player:startEvent(35, xi.ki.SEA_SERPENT_STATUE) -- Finish quest
        else
            player:startEvent(34) -- Reminder Dialogue
        end
    else
        player:startEvent(83) -- Standard Conversation
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 33 and option == 1 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SAHAGINS_STASH)
    elseif csid == 35 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4946)
        else
            player:delKeyItem(xi.ki.SEA_SERPENT_STATUE)
            player:addItem(4946) -- Scroll of Utsusemi: Ichi
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4946)
            player:addTitle(xi.title.TREASURE_HOUSE_RANSACKER)
            player:addFame(xi.quest.fame_area.NORG, 75)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SAHAGINS_STASH)
        end
    end
end

return entity
