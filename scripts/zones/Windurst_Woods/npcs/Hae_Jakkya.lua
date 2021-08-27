-----------------------------------
-- Area: Windurst Woods
--  NPC: Hae Jakkya
-- Involved in quest: Chasing Tales
-- !pos 57.387 -2.5 -140.757 241
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES) == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
            player:startEvent(406)
        elseif player:getCharVar("CHASING_TALES_TRACK_BOOK") == 1 then
            player:startEvent(403, 0, xi.ki.A_SONG_OF_LOVE)
        elseif player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION) then
            player:startEvent(402, 0, xi.ki.A_SONG_OF_LOVE)
        else
            player:startEvent(41)
        end
    else
        player:startEvent(41)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 402 then
        player:setCharVar("CHASING_TALES_TRACK_BOOK", 1)
    end
end

return entity
