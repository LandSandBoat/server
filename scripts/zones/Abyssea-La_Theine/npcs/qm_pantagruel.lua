-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_pantagruel (???)
-- Spawns Pantagruel
-- !pos -356 8 163 132
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PANTAGRUEL, { xi.items.OVERSIZED_SOCK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.OVERSIZED_SOCK })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
