-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm9 (???)
-- Spawns Karkatakam
-- !pos 200 -15 519 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KARKATAKAM, { xi.items.SLICE_OF_HIGH_QUALITY_CRAB_MEAT, xi.items.CHUNK_OF_HIGH_QUALITY_ROCK_SALT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.SLICE_OF_HIGH_QUALITY_CRAB_MEAT, xi.items.CHUNK_OF_HIGH_QUALITY_ROCK_SALT })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
