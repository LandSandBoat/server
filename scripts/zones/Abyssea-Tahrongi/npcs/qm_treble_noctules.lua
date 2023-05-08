-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_treble_noctules (???)
-- Spawns Treble Noctules
-- !pos 190 -22 -153 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TREBLE_NOCTULES, { xi.items.BLOODY_FANG, xi.items.EXORCISED_SKULL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BLOODY_FANG, xi.items.EXORCISED_SKULL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
