-----------------------------------
-- Area: Lower Jeuno
--  NPC: Shashan-Mishan
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10012, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
