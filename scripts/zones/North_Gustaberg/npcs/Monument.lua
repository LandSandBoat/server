-----------------------------------
-- Area: North Gustaberg
--  NPC: Monument
-- Involved in Quest "Hearts of Mythril"
-- !pos 300.000 -62.803 498.200 106
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.HEARTS_OF_MYTHRIL) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.BOUQUET_FOR_THE_PIONEERS)
    then
        player:startEvent(11)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 11 and option == 0 then
        player:setCharVar("HeartsOfMythril", 1)
        player:delKeyItem(xi.ki.BOUQUET_FOR_THE_PIONEERS)
    end
end

return entity
