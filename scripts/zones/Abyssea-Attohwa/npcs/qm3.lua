-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm3 (???)
-- Spawns Pallid Percy
-- !pos 281.063 20.376 174.011 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PALLID_PERCY, { xi.items.VIAL_OF_UNDYING_OOZE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_UNDYING_OOZE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
