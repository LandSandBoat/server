-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (4)
-- !pos -742.126 -160 -144.889 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(34, 0, 0, 0, 0, 0, 4)
end

return entity
