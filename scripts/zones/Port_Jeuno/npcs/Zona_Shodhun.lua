-----------------------------------
-- Area: Port Jeuno
--  NPC: Zona Shodhun
-- Starts and Finishes Quest: Pretty Little Things
-- !pos -175 -5 -4 246
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10023, 0, 246, 10)
end

return entity
