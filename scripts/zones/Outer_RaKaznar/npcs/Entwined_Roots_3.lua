-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (3)
-- !pos -657.482 -150 -265.664 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(33, 0, 0, 0, 0, 0, 3)
end

return entity
