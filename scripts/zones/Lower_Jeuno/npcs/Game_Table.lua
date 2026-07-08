-----------------------------------
-- Game Table
-- Basic Chat Text
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10073)
end

return entity
