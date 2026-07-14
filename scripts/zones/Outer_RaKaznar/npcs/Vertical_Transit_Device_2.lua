-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device
-- !pos -506.698 -141 -20 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(44, 0, 300, 0, 100, 0, 2, 0, 0)
end

return entity
