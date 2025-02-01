-----------------------------------
-- Area: Al Zahbi
--  NPC: Krujaal
-- !pos 36.522 0.000 -63.198 48
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 0, 7)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 0)
end

return entity
