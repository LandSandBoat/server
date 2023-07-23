-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_bugul_noz (???)
-- Spawns Bugul Noz
-- !pos -608 -1 -397 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BUGUL_NOZ, { xi.items.HANDFUL_OF_SABULOUS_CLAY })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HANDFUL_OF_SABULOUS_CLAY })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
