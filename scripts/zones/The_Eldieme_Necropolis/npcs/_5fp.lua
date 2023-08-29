-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: West Plate
-- !pos 128 -34 20 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.plateOnTrigger(npc)
    return 0
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
