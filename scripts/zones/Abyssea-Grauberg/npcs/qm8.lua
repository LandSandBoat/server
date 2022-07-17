-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm8 (???)
-- Spawns Ika-Roa
-- !pos 158 -29 -215 254
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IKA_ROA, { xi.items.HIGH_QUALITY_PUGIL_SCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.HIGH_QUALITY_PUGIL_SCALE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
