-----------------------------------
-- Area: Port Bastok
--  NPC: Fo Mocorho
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(116, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
