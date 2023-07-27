-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_burstrox_powderpate (???)
-- Spawns Burstrox Powderpate
-- !pos 396 40 -436 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BURSTROX_POWDERPATE, { xi.items.LENGTH_OF_GOBLIN_ROPE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.LENGTH_OF_GOBLIN_ROPE })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
