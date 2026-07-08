-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_teugghia (???)
-- Spawns Teugghia
-- !pos -68 -6 656 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.TEUGGHIA, { xi.item.NAIADS_LOCK, xi.item.UNSEELIE_EYE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.NAIADS_LOCK, xi.item.UNSEELIE_EYE })
end

return entity
