-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm1 (???)
-- Spawns Ironclad Smiter
-- !pos -744 -17 -696 218
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IRONCLAD_SMITER, { xi.items.VIAL_OF_TABLILLA_MERCURY, xi.items.SMOLDERING_ARM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_TABLILLA_MERCURY, xi.items.SMOLDERING_ARM })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
