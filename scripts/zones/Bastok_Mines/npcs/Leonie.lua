-----------------------------------
-- Area: Bastok Mines
--  NPC: Leonie
-- !pos 118.871 0.996 -83.916 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 568)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 568)
end

return entity
