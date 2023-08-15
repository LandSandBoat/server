-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_cannered_noz (???)
-- Spawns Cannered Noz
-- !pos -355 4 251 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CANNERED_NOZ, { xi.items.BALEFUL_SKULL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BALEFUL_SKULL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
