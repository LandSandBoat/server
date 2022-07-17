-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm21 (???)
-- Spawns Cirein-Croin
-- !pos 38 -15 534 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CIREIN_CROIN_2, { xi.ki.GLISTENING_OROBON_LIVER, xi.ki.DOFFED_POROGGO_HAT })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
