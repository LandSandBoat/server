-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_gancanagh (???)
-- Spawns Gancanagh
-- !pos 74 11 -51 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GANCANAGH, { xi.items.CLUMP_OF_ALKALINE_HUMUS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CLUMP_OF_ALKALINE_HUMUS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
