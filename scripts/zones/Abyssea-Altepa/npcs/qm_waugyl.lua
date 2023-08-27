-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_waugyl (???)
-- Spawns Waugyl
-- !pos -408 1 -299 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.WAUGYL, { xi.items.VIAL_OF_PUPPETS_BLOOD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_PUPPETS_BLOOD })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
