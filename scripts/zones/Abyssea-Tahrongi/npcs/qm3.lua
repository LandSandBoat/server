-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm3 (???)
-- Spawns Ophanim
-- !pos -195 -16 -165 45
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.OPHANIM, { xi.items.BLOODSHOT_HECTEYE, xi.items.SHRIVELED_WING, xi.items.TARNISHED_PINCER  })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BLOODSHOT_HECTEYE, xi.items.SHRIVELED_WING, xi.items.TARNISHED_PINCER  })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
