-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Barricade
-- Involved in Quests: The Fighting Fourth
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and
        player:getCharVar("THE_FIGHTING_FOURTH") == 2
    then
        player:startEvent(106)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 106 then
        player:setCharVar("THE_FIGHTING_FOURTH", 3)
    end
end

return entity
