-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_hedetet (???)
-- Spawns Hedetet
-- !pos -279 7 126 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.HEDETET, { xi.item.VENOMOUS_SCORPION_STINGER, xi.item.CLUMP_OF_ACIDIC_HUMUS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.VENOMOUS_SCORPION_STINGER, xi.item.CLUMP_OF_ACIDIC_HUMUS })
end

return entity
