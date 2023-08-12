-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_shaula (???)
-- Spawns Shaula
-- !pos -71 0 408 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SHAULA, { xi.items.VIAL_OF_VADLEANY_FLUID, xi.items.HIGH_QUALITY_SCORPION_CLAW })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_VADLEANY_FLUID, xi.items.HIGH_QUALITY_SCORPION_CLAW })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
