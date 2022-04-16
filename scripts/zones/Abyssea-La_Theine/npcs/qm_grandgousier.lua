-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_grandgousier (???)
-- Spawns Grandgousier
-- !pos -398 .010 -322 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GRANDGOUSIER, { xi.items.MASSIVE_ARMBAND })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.MASSIVE_ARMBAND })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
