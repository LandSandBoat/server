-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm9 (???)
-- Spawns Alectryon
-- !pos -42 -8 34 45
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ALECTRYON, { xi.items.CHUNK_OF_COCKATRICE_TAILMEAT, xi.items.QUIVERING_EFT_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CHUNK_OF_COCKATRICE_TAILMEAT, xi.items.QUIVERING_EFT_EGG })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
