-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (2)
-- !pos -262.135 -160 -305.495 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(32, 0, 0, 0, 0, 0, 2)
end

return entity
