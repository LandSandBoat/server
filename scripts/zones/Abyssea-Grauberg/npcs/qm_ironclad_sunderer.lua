-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_ironclad_sunderer (???)
-- Spawns Ironclad Sunderer
-- !pos 501 25 503 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IRONCLAD_SUNDERER, { xi.items.TEEKESSELCHEN_FRAGMENT, xi.items.DARKFLAME_ARM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.TEEKESSELCHEN_FRAGMENT, xi.items.DARKFLAME_ARM })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
