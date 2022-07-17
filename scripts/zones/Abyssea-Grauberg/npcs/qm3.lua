-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm3 (???)
-- Spawns Teugghia
-- !pos -68 -6 656 254
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TEUGGHIA, { xi.items.NAIADS_LOCK, xi.items.UNSEELIE_EYE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.NAIADS_LOCK, xi.items.UNSEELIE_EYE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
