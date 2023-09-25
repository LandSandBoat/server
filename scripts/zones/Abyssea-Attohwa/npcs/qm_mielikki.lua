-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_mielikki (???)
-- Spawns Mielikki
-- !pos 481.096 20.000 39.549 215
-----------------------------------
local ID = require('scripts/zones/Abyssea-Attohwa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MIELIKKI, { xi.items.GREAT_ROOT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GREAT_ROOT })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
