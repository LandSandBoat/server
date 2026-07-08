-----------------------------------
-- Area: Port Windurst
--  NPC: Eya Bhithroh
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10006, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
