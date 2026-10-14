-----------------------------------
-- Area: Port Bastok (236)
--  NPC: Suspicious Galka
-- !pos 81.610 8.499 -229.065 236
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
