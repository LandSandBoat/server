-----------------------------------
-- Area: Bastok Mines
--  NPC: Roh Latteh
-- Finishes Quest: The Signpost Marks the Spot
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.PAINTING_OF_A_WINDMILL)
    then
        player:startEvent(96)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 96 then
        if player:getFreeSlotsCount() > 0 then
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT)
            player:delKeyItem(xi.ki.PAINTING_OF_A_WINDMILL)
            player:addTitle(xi.title.TREASURE_SCAVENGER)
            player:addFame(xi.quest.fame_area.BASTOK, 50)
            player:addItem(12601)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12601) -- Linen Robe
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12601)
        end
    end
end

return entity
