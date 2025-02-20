-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Roderich
-- Involved in Quests: The Fighting Fourth
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('THE_FIGHTING_FOURTH') == 1
    then
        player:startEvent(104)
    elseif
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('THE_FIGHTING_FOURTH') == 3
    then
        player:startEvent(109)
    else
        player:startEvent(111)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 104 then
        player:setCharVar('THE_FIGHTING_FOURTH', 2)
    end
end

return entity
