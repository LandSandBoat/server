-----------------------------------
-- Area: Bastok Markets
--  NPC: Hildith
-- !pos -176.664 -8.000 25.158 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 488)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 488)
end

return entity
