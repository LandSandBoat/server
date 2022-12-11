-----------------------------------
-- Area: Upper Jeuno
--  NPC: Galmut's door
-- Starts and Finishes Quest: A Clock Most Delicate, Save the Clock Tower, The Clockmaster
-- !pos -80 0 104 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CLOCKMASTER) == QUEST_AVAILABLE
    then
        player:startEvent(152) -- Start & finish quest "The Clockmaster"

    elseif player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CLOCKMASTER) == QUEST_COMPLETED then
        player:startEvent(110) -- After quest "The Clockmaster"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 152 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17083)
        else
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CLOCKMASTER)
            player:addTitle(xi.title.TIMEKEEPER)
            player:addGil(1200)
            player:messageSpecial(ID.text.GIL_OBTAINED, 1200)
            player:addItem(17083)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17083)
            player:addFame(xi.quest.fame_area.JEUNO, 30)
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CLOCKMASTER)
        end
    end
end

return entity
