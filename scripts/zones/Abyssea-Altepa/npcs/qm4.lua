-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm4 (???)
-- Spawns Emperador de Altepa
-- !pos -491 0 -611 218
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.EMPERADOR_DE_ALTEPA, { xi.items.BOTTLE_OF_OASIS_WATER, xi.items.SPRIG_OF_GIANT_MISTLETOE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.BOTTLE_OF_OASIS_WATER, xi.items.SPRIG_OF_GIANT_MISTLETOE })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
