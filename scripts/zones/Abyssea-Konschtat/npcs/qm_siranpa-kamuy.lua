-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_siranpa-kamuy (???)
-- Spawns Siranpa-Kamuy
-- !pos 370.000 1.601 10.000 15
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SIRANPA_KAMUY, { xi.items.ROTTING_EYEBALL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.ROTTING_EYEBALL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
