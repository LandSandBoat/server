-----------------------------------
-- Area: Bastok Markets
--  NPC: Loulia
-- !pos -176.212 -8.000 -25.049 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 487)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 487)
end

return entity
