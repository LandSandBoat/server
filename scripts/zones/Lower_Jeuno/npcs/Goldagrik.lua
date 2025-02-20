-----------------------------------
-- Area: Lower Jeuno
--  NPC: Goldagrik
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(20006)
end

return entity
