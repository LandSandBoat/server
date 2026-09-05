-----------------------------------
-- Area: Windurst Woods
--  NPC: Boizo-Naizo
-- Involved in Quests: A Greeting Cardian, Riding on the Clouds
-- !pos -9.581 -2.750 -26.062 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ALL_NEW_C_2000) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(290)
    end
end

return entity
