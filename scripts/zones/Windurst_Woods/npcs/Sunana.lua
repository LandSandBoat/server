-----------------------------------
-- Area: Windurst Woods
--  NPC: Sunana
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(409, 0, 17088)
end

return entity
