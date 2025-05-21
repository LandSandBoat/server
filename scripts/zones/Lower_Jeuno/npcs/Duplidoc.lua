-----------------------------------
-- Area: Lower Jeuno
--  NPC: Duplidoc
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(20008)
end

return entity
