-----------------------------------
-- Area: Windurst Woods
--  NPC: Bopa Greso
-- !pos 59.773 -6.249 216.766 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO) == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(84)
    end
end

return entity
