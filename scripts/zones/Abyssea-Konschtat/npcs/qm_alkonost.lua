-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_alkonost (???)
-- Spawns Alkonost
-- !pos 54.000 30.654 414.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ALKONOST, { xi.items.GIANT_BUGARD_TUSK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GIANT_BUGARD_TUSK })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
