-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm3 (???)
-- Spawns Shaula
-- !pos -71 0 408 218
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SHAULA, { xi.items.VIAL_OF_VADLEANY_FLUID, xi.items.HIGH_QUALITY_SCORPION_CLAW })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_VADLEANY_FLUID, xi.items.HIGH_QUALITY_SCORPION_CLAW })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
