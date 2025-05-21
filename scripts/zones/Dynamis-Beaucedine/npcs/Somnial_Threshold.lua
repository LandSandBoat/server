-----------------------------------
-- Area: Dynamis
--  NPC: Somnial Threshold
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.dynamis.somnialThresholdOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.dynamis.somnialThresholdOnEventFinish(player, csid, option, npc)
end

return entity
