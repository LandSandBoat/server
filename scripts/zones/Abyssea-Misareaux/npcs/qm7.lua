-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm7 (???)
-- Spawns Nehebkau
-- !pos 321 23 -355 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NEHEBKAU, { xi.items.HARDENED_RAPTOR_SKIN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HARDENED_RAPTOR_SKIN })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
