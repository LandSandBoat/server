-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_lorelei (???)
-- Spawns Lorelei
-- !pos -192 -31 480 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LORELEI, { xi.items.FAY_TEARDROP })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.FAY_TEARDROP })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
