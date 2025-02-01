-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Fulchia
-- !pos 158.522 -1.999 164.928 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: 585, 587?
    xi.moghouse.visitationNPCOnTrigger(player, npc, 893)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 893)
end

return entity
