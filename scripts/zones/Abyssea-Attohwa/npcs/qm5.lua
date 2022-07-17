-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm5 (???)
-- Spawns Kharon
-- !pos -403.909 -4.234 200.832 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KHARON, { xi.items.SET_OF_WAILING_RAGS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.SET_OF_WAILING_RAGS })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
