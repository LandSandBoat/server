-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_lentor (???)
-- Spawns Lentor
-- !pos -248.000 47.971 403.000 15
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LENTOR, { xi.items.GIANT_SLUG_EYESTALK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.GIANT_SLUG_EYESTALK })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
