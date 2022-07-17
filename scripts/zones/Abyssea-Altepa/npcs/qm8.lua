-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm8 (???)
-- Spawns Chickcharney
-- !pos 36 0 -240 218
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CHICKCHARNEY, { xi.items.HIGH_QUALITY_COCKATRICE_SKIN  })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HIGH_QUALITY_COCKATRICE_SKIN  })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
