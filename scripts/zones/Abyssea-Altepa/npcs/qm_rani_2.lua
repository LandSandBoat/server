-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_rani_2 (???)
-- Spawns Rani
-- !pos -801 -7.8 -368 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.RANI_OFFSET + 4, { xi.ki.BROKEN_IRON_GIANT_SPIKE, xi.ki.RUSTED_CHARIOT_GEAR })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
