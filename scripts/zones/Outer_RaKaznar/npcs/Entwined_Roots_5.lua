-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (5)
-- !pos -582.197 -160 254.668 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(35, 0, 0, 0, 0, 0, 5)
end

return entity
