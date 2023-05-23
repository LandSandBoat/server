-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_vetehinen (???)
-- Spawns Vetehinen
-- !pos 74 .001 -435 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.VETEHINEN, { xi.items.HIGH_QUALITY_LIMULE_PINCER })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HIGH_QUALITY_LIMULE_PINCER })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
