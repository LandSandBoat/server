-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm5 (???)
-- Spawns Cep-Kamuy
-- !pos -160 -15 638 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CEP_KAMUY, { xi.items.CHUNK_OF_OROBON_CHEEKMEAT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.CHUNK_OF_OROBON_CHEEKMEAT })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
