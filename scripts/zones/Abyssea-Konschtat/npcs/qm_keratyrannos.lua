-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_keratyrannos (???)
-- Spawns Keratyrannos
-- !pos -134.000 47.371 416.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KERATYRANNOS, { xi.items.ARMORED_DRAGONHORN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.ARMORED_DRAGONHORN })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
