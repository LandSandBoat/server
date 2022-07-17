-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm13 (???)
-- Spawns Mielikki
-- !pos 481.096 20.000 39.549 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MIELIKKI, { xi.items.GREAT_ROOT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GREAT_ROOT })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
