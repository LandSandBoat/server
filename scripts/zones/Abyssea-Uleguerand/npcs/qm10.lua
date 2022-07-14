-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm10 (???)
-- Spawns Audumbla
-- !pos 337 20 -277 253
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.AUDUMBLA, { xi.items.HIGH_QUALITY_BUFFALO_HORN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HIGH_QUALITY_BUFFALO_HORN })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
