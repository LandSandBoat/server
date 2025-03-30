-----------------------------------
-- Area: Windurst Walls
--  NPC: Shinchai-Tocchai
-- !pos -220.551 0.999 -116.916 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Caps: 505, 0, 3, 1, 300, 2600, 1543, 1411472642, 128
    xi.moghouse.visitationNPCOnTrigger(player, npc, 505)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 505)
end

return entity
