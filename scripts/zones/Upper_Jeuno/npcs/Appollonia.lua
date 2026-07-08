-----------------------------------
-- Area: Upper Jeuno
--  NPC: Appollonia
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10008, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
