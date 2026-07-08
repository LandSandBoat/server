-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Titan's Gate
-- !pos 180 -34 -15 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.gateOnTrigger(player, npc)
end

return entity
