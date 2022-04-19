-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_la_theine_liege (???)
-- Spawns La Theine Liege
-- !pos 80 15 199 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LA_THEINE_LIEGE, { xi.items.TRANSPARENT_INSECT_WING })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.TRANSPARENT_INSECT_WING })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
