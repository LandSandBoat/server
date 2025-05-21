-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_ophanim (???)
-- Spawns Ophanim
-- !pos -195 -16 -165 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.OPHANIM, { xi.item.SHRIVELED_WING, xi.item.TARNISHED_PINCER, xi.item.BLOODSHOT_HECTEYE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.SHRIVELED_WING, xi.item.TARNISHED_PINCER, xi.item.BLOODSHOT_HECTEYE })
end

return entity
