-----------------------------------
-- Area: Castle Oztroja
--  NPC: _476 (Brass Door)
-- !pos 145.005 -19.989 -140.000 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(6)
end

return entity
