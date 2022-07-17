-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm10 (???)
-- Spawns Maahes
-- !pos 214.107 19.970 -93.816 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MAAHES, { xi.items.COEURL_ROUND })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.COEURL_ROUND })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
