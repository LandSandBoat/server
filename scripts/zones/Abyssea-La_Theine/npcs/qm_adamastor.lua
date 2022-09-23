-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_adamastor (???)
-- Spawns Adamastor
-- !pos -716 15 639 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ADAMASTOR, { xi.items.TROPHY_SHIELD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.TROPHY_SHIELD })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
