-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm5 (???)
-- Spawns Treble Noctules
-- !pos 190 -22 -153 45
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TREBLE_NOCTULES, { xi.items.BLOODY_FANG, xi.items.EXORCISED_SKULL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BLOODY_FANG, xi.items.EXORCISED_SKULL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
