-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: West Plate
-- !pos 150 -32 14 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.plateOnTrigger(npc)
end

return entity
