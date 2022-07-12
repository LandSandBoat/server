-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm11 (???)
-- Spawns Pascerpot
-- !pos -214 -47 -593 217
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PASCERPOT, { xi.items.CRAWLER_FLOATSTONE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CRAWLER_FLOATSTONE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
