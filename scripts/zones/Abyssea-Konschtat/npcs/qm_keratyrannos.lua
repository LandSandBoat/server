-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_keratyrannos (???)
-- Spawns Keratyrannos
-- !pos -134.000 47.371 416.000 15
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KERATYRANNOS, { xi.items.ARMORED_DRAGONHORN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.ARMORED_DRAGONHORN })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
