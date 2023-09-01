-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Odin's Gate
-- !pos 260 -34 110 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.gateOnTrigger(player, npc)
    return 0
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
