-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: East Plate
-- !pos 210 -32 25 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.plateOnTrigger(npc)
end

return entity
