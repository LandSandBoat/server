-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device
-- !pos 580 99 -67.1 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(46, 1, 300, 1, 100, 0, 4, 0, 0)
end

return entity
