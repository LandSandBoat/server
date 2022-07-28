-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_teekesselchen (???)
-- Spawns Teekesselchen
-- !pos 319 47 643 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TEEKESSELCHEN, { xi.items.FLASK_OF_BUBBLING_OIL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.FLASK_OF_BUBBLING_OIL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
