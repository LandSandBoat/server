-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm9 (???)
-- Spawns Chillwing Hwitti
-- !pos -484 -20 -85 253
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CHILLWING_HWITTI, { xi.items.IMP_SENTRYS_HORN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.IMP_SENTRYS_HORN })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
