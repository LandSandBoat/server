-----------------------------------
-- Area: Windurst Waters
--  NPC: Five of Hearts
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(686)
    else
        player:startEvent(273)
    end
end

return entity
