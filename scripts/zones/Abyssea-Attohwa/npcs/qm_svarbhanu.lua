-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_svarbhanu (???)
-- Spawns Svarbhanu
-- !pos -545.043 -12.410 -72.175 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SVARBHANU, { xi.items.CRACKED_DRAGONSCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CRACKED_DRAGONSCALE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
