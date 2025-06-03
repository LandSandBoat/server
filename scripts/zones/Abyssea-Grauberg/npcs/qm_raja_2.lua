-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_raja_2 (???)
-- Spawns Raja
-- !pos 495 56 679 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.RAJA_OFFSET + 4, { xi.ki.WARPED_CHARIOT_PLATE, xi.ki.SHATTERED_IRON_GIANT_CHAIN })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
