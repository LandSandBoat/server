-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm7 (???)
-- Spawns Xiabalba
-- !pos -487 -168 211 254
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.XIABALBA, { xi.items.DECAYING_MOLAR })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.DECAYING_MOLAR })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
