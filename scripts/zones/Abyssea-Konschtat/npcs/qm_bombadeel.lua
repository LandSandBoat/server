-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_bombadeel (???)
-- Spawns Bombadeel
-- !pos -358.000 8.000 -42.000 15
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BOMBADEEL, { xi.items.CLUMP_OF_SNAKESKIN_MOSS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CLUMP_OF_SNAKESKIN_MOSS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
