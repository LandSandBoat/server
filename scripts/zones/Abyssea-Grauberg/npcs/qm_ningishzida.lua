-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_ningishzida (???)
-- Spawns Ningishzida
-- !pos 380 -31 239 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NINGISHZIDA, { xi.items.MINARUJA_SKULL, xi.items.JACULUS_WING, xi.items.HIGH_QUALITY_WIVRE_HIDE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.MINARUJA_SKULL, xi.items.JACULUS_WING, xi.items.HIGH_QUALITY_WIVRE_HIDE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
