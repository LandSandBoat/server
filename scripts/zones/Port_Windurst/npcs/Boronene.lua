-----------------------------------
-- Area: Port Windurst
--  NPC: Boronene
-- !pos 201.651 -12.000 229.584 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.moghouse.visitationNPCOnTrigger(player, npc, 638)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 638)
end

return entity
