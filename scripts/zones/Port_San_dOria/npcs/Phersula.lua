-----------------------------------
-- Area: Port San d'Oria
--  NPC: Phersula
-- !pos 80.316 -15.999 -134.112 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 775)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 775)
end

return entity
