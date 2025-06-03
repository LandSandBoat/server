-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_gancanagh (???)
-- Spawns Gancanagh
-- !pos 74 11 -51 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GANCANAGH, { xi.item.CLUMP_OF_ALKALINE_HUMUS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.CLUMP_OF_ALKALINE_HUMUS })
end

return entity
