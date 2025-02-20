-----------------------------------
-- Area: Bastok Mines
--  NPC: Mariadok
-- Type: Weather Reporter
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(2, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
