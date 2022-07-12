-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm9 (???)
-- Spawns Chhir Batti
-- !pos -395.665 -31.565 358.085 217
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CHHIR_BATTI, { xi.items.VIAL_OF_DJINN_ASHES })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_DJINN_ASHES })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
