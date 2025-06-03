-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_vetehinen (???)
-- Spawns Vetehinen
-- !pos 74 .001 -435 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.VETEHINEN, { xi.item.HIGH_QUALITY_LIMULE_PINCER })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.HIGH_QUALITY_LIMULE_PINCER })
end

return entity
