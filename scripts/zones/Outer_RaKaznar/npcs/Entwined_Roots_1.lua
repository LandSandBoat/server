-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (1)
-- !pos -222.581 -150 -145.591 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(31, 0, 0, 0, 0, 0, 1)
end

return entity
