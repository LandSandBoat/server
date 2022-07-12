-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm5 (???)
-- Spawns Kadraeth the Hatespawn
-- !pos -475 -40 -280 217
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KADRAETH_THE_HATESPAWN, { xi.items.STIFFENED_TENTACLE  })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.STIFFENED_TENTACLE  })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
