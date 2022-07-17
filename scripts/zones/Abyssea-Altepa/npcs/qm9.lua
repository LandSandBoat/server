-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm9 (???)
-- Spawns Vadleany
-- !pos -56 1 123 218
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.VADLEANY, { xi.items.LADYBIRD_LEAF })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.LADYBIRD_LEAF })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
