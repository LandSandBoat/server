-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_rani_1 (???)
-- Spawns Rani
-- !pos -812 -9 -379 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.RANI_1, { xi.ki.BROKEN_IRON_GIANT_SPIKE, xi.ki.RUSTED_CHARIOT_GEAR })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
