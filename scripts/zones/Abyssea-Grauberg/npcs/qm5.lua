-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm5 (???)
-- Spawns Teekesselchen
-- !pos 319 47 643 254
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
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
