-----------------------------------
-- Zone: Abyssea - Uleguerand
--  NPC: Conflux Surveyor
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.surveyorOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.surveyorOnEventFinish(player, csid, option, npc)
end

return entity
