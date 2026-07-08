-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47o
-- !pos -155.228 21.500 -140.000 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(6)
end

return entity
