-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm12 (???)
-- Spawns Lachrymater
-- !pos -220 -1 -299 45
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LACHRYMATER, { xi.items.MOANING_VESTIGE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.MOANING_VESTIGE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
