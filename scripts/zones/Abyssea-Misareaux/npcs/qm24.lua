-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm24 (???)
-- Spawns Ironclad Pulverizor
-- !pos -199 -31 145 216
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.IRONCLAD_PULVERIZOR_2, { xi.ki.BLAZING_CLUSTER_SOUL, xi.ki.SCALDING_IRONCLAD_SPIKE })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
