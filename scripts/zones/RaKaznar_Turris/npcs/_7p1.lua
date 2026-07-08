-----------------------------------
-- Area: RaKaznar Turris
--  NPC: _7p1 (Vertical Transit Device)
-- !pos 74 -33 20 277
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(15)
end

return entity
