-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: South Plate
-- !pos 185 -32 -10 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.plateOnTrigger(npc)
end

return entity
