-----------------------------------
-- Area: Port Bastok
--  NPC: Wurteh
-- !pos 72.782 8.499 -242.102 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: What is csid 95?
    xi.moghouse.visitationNPCOnTrigger(player, npc, 382)
end

entity.onEventFinish = function(player, csid, option)
    xi.moghouse.visitationNPCOnEventFinish(player, csid, option, 382)
end

return entity
