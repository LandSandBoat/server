-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_carabosse (???)
-- Spawns Carabosse
-- !pos 11 17 148 132
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
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CARABOSSE_1, { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
