-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: ??? (_7mk) Door for Silvery Plate
-- !pos -923 -192 -20 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(15)
end

return entity
