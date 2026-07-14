-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device
-- !pos 532.889 99 -19.942 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(47, 1, 300, 1, 100, 0, 5, 0, 0)
end

return entity
