-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: North Plate
-- !pos 180 -34 71 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.plateOnTrigger(npc)
end

return entity
