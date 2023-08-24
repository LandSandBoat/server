-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_granite_borer (???)
-- Spawns Granite Borer
-- !pos 401.489 19.730 -282.864 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GRANITE_BORER, { xi.items.WITHERED_COCOON })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.WITHERED_COCOON })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
