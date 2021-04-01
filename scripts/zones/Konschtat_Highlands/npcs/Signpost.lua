-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Signpost
-- Involved in Quest: The Signpost Marks the Spot
-- !pos -183 65 599 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT) == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.PAINTING_OF_A_WINDMILL)
    then
        player:messageSpecial(ID.text.SIGNPOST_DIALOG_2)
        player:addKeyItem(xi.ki.PAINTING_OF_A_WINDMILL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PAINTING_OF_A_WINDMILL)
    else
        player:messageSpecial(ID.text.SIGNPOST_DIALOG_1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
