-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: ???
-- Involved in Quest: Unforgiven
-- !pos 110.714 -40.856 -53.154 26
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local unforgiven = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)

    if
        unforgiven == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN)
    then
        player:addKeyItem(xi.ki.ALABASTER_HAIRPIN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ALABASTER_HAIRPIN) -- ALABASTER HAIRPIN for Unforgiven Quest
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
