-----------------------------------
-- Area: Windurst Woods
--  NPC: Abby Jalunshi
-- !pos -101.895 -4.000 36.172 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 798)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 798)
end

return entity
