-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zhamwaa
-- !pos -103.323 0.001 -76.504 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 500, 7)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 500)
end

return entity
