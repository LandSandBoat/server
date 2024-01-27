-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Roderich
-- Involved in Quests: The Fighting Fourth
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and
        player:getCharVar('THE_FIGHTING_FOURTH') == 1
    then
        player:startEvent(104)
    elseif
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == QUEST_ACCEPTED and
        player:getCharVar('THE_FIGHTING_FOURTH') == 3
    then
        player:startEvent(109)
    else
        player:startEvent(111)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 104 then
        player:setCharVar('THE_FIGHTING_FOURTH', 2)
    end
end

return entity
