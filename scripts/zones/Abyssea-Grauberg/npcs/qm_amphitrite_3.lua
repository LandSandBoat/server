-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_amphitrite_3 (???)
-- Spawns Amphitrite
-- !pos -162 -31 -220 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.AMPHITRITE_3, { xi.ki.VARIEGATED_URAGNITE_SHELL })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
