-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_arimaspi (???)
-- Spawns Arimaspi
-- !pos 438.000 31.922 358.000 15
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ARIMASPI, { xi.items.CLOUDED_LENS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CLOUDED_LENS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
