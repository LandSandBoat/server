-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm11 (???)
-- Spawns Nightshade
-- !pos 410.304 19.500 13.227 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NIGHTSHADE, { xi.items.WITHERED_BUD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.WITHERED_BUD })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
