-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_ningishzida (???)
-- Spawns Ningishzida
-- !pos 380 -31 239 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NINGISHZIDA, { xi.item.MINARUJA_SKULL, xi.item.JACULUS_WING, xi.item.HIGH_QUALITY_WIVRE_HIDE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.MINARUJA_SKULL, xi.item.JACULUS_WING, xi.item.HIGH_QUALITY_WIVRE_HIDE })
end

return entity
