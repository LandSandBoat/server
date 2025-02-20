-----------------------------------
-- Area: GM Home
--  NPC: Listener
-- Type: Debug NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(120)
end

return entity
