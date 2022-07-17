-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm12 (???)
-- Spawns Npfundlwa
-- !pos 412 -7 50 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NPFUNDLWA, { xi.items.BLACK_RABBIT_TAIL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BLACK_RABBIT_TAIL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
