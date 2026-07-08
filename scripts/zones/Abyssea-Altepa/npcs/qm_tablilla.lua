-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_tablilla (???)
-- Spawns Tablilla
-- !pos -877 -8 -524 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TABLILLA, { xi.item.SANDY_SHARD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.SANDY_SHARD })
end

return entity
