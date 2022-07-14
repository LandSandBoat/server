-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm4 (???)
-- Spawns Yaguarogui
-- !pos 432 .001 -424 253
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.YAGUAROGUI, { xi.items.AUDUMBLA_HIDE, xi.items.HIGH_QUALITY_BLACK_TIGER_HIDE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.AUDUMBLA_HIDE, xi.items.HIGH_QUALITY_BLACK_TIGER_HIDE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
