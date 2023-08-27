-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_nightshade (???)
-- Spawns Nightshade
-- !pos 410.304 19.500 13.227 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NIGHTSHADE, { xi.items.WITHERED_BUD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.WITHERED_BUD })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
