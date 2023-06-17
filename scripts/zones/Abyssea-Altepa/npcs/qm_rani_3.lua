-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_rani_3 (???)
-- Spawns Rani
-- !pos 102 0 -151 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.RANI_3, { xi.ki.BROKEN_IRON_GIANT_SPIKE, xi.ki.RUSTED_CHARIOT_GEAR })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
