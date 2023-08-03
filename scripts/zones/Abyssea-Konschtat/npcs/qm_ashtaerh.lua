-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_ashtaerh (???)
-- Spawns Ashtaerh the Gallvexed
-- !pos 360.000 -16.043 -400.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ASHTAERH_THE_GALLVEXED, { xi.items.MURMURING_GLOBULE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.MURMURING_GLOBULE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
