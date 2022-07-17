-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm11 (???)
-- Spawns Tuskertrap
-- !pos -22 -23 656 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TUSKERTRAP, { xi.items.SPOTTED_FLYFROND })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.SPOTTED_FLYFROND })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
