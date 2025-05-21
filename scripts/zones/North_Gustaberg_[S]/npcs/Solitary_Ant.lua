-----------------------------------
-- Area: North Gustaberg (S) (J-9)
--  NPC: Solitary Ant
-- Involved in Quests: Fire in the Hole
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(2)
    else
        player:startEvent(112)
    end
end

return entity
