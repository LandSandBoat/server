-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_raja_1 (???)
-- Spawns Raja
-- !pos 481 56 680 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.RAJA_1, { xi.ki.WARPED_CHARIOT_PLATE, xi.ki.SHATTERED_IRON_GIANT_CHAIN })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
