-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_muscaliet (???)
-- Spawns Muscaliet
-- !pos 253 46 291 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MUSCALIET, { xi.item.RESILIENT_MANE, xi.item.SMOOTH_WHISKER })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.RESILIENT_MANE, xi.item.SMOOTH_WHISKER })
end

return entity
