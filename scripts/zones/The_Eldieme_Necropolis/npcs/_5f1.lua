-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Shiva's Gate
-- !pos 215 -34 20 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.gateOnTrigger(player, npc)
end

return entity
