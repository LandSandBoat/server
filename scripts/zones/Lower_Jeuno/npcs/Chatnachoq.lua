-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chatnachoq
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10095)
end

return entity
