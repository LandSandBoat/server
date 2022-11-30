-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Gebhardt
-- Involved in Quests: The Fighting Fourth
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.BATTLE_RATIONS)
    then
        player:startEvent(102)
    else
        player:startEvent(110)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 102 then
        player:delKeyItem(xi.ki.BATTLE_RATIONS)
        player:setCharVar("THE_FIGHTING_FOURTH", 1)
    end
end

return entity
