-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Barricade
-- Involved in Quests: The Fighting Fourth
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('THE_FIGHTING_FOURTH') == 2
    then
        player:startEvent(106)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 106 then
        player:setCharVar('THE_FIGHTING_FOURTH', 3)
    end
end

return entity
