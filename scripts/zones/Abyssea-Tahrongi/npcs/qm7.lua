-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm7 (???)
-- Spawns Hedetet
-- !pos -279 7 126 45
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.HEDETET, { xi.items.VENOMOUS_SCORPION_STINGER, xi.items.CLUMP_OF_ACIDIC_HUMUS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VENOMOUS_SCORPION_STINGER, xi.items.CLUMP_OF_ACIDIC_HUMUS  })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
