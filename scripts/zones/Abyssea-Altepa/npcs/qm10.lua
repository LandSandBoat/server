-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm10 (???)
-- Spawns Bugul Noz
-- !pos -608 -1 -397 218
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BUGUL_NOZ, { xi.items.HANDFUL_OF_SABULOUS_CLAY })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HANDFUL_OF_SABULOUS_CLAY })
end
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
