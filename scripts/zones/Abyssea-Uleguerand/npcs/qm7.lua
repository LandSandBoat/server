-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm7 (???)
-- Spawns Veri Selen
-- !pos 13 -140 470 253
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.VERI_SELEN, { xi.items.ICE_WYVERN_SCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.ICE_WYVERN_SCALE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
