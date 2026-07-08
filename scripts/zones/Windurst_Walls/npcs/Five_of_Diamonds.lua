-----------------------------------
-- Area: Windurst Walls
--  NPC: Five of Diamonds
-- !pos -220.954 -0.001 -122.708 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(339)
    else
        player:startEvent(266)
    end
end

return entity
