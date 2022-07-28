-----------------------------------
-- Area: Port Bastok
--  NPC: Tete
-- Continues Quest: The Wisdom Of Elders
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WISDOM_OF_ELDERS) == QUEST_ACCEPTED) then
        player:startEvent(175)
    else
        player:startEvent(35)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 175) then
        player:setCharVar("TheWisdomVar", 2)
    end

end

return entity
