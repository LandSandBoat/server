-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Pradiulot
-- Involved in Quest: Unforgiven
-- !pos -20.814 -22 8.399 26
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local unforgiven = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)

    if unforgiven == QUEST_ACCEPTED and player:getCharVar("UnforgivenVar") == 1 then
        player:startEvent(204) -- Dialogue for final stage of Unforgiven Quest
    elseif
        unforgiven == QUEST_COMPLETED and
        player:getCharVar("UnforgivenVar") == 2
    then
        player:startEvent(206) -- Dialogue after completing quest (optional)
    else
        player:startEvent(371) -- Default Dialogue TODO: Dialogue default is 192 before Unforgiven, so this might change
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 204 then
        player:setCharVar("UnforgivenVar", 2)
        player:addKeyItem(xi.ki.MAP_OF_TAVNAZIA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MAP_OF_TAVNAZIA) -- Map of Tavnazia
        player:addExp(2000 * xi.settings.main.EXP_RATE)
        player:addGil(2000 * xi.settings.main.GIL_RATE)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)
    elseif csid == 206 then
        player:setCharVar("UnforgivenVar", 0)
    end
end

return entity
