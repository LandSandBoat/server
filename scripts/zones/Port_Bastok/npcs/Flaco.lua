-----------------------------------
-- Area: Port Bastok
--  NPC: Flaco
-- Fame Checker
-- !zone 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(210 + player:getFameLevel(xi.fameArea.BASTOK))
end

return entity
