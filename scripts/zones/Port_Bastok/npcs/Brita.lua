-----------------------------------
-- Area: Port Bastok
--  NPC: Brita
-- !pos 58.161 -3.101 -6.695 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(346, 0, 1)
end

return entity
