-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (6)
-- !pos -337.826 -160 294.713 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(36, 0, 0, 0, 0, 0, 6)
end

return entity
