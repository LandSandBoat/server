-----------------------------------
-- Area: Port Windurst (240)
--  NPC: Suspicious Tarutaru
-- !pos 221.286 -12.000 225.311 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.gladiatorOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.gladiatorOnEventFinish(player, csid, option, npc)
end

return entity
