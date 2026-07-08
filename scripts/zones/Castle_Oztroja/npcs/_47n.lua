-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47n
-- !pos -40.811 -17.492 -140.000 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(6)
end

return entity
