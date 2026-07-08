-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Odin's Gate
-- !pos 180 -34 55 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.gateOnTrigger(player, npc)
end

return entity
