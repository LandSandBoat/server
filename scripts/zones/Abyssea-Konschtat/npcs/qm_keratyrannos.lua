-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_keratyrannos (???)
-- Spawns Keratyrannos
-- !pos -134.000 47.371 416.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.KERATYRANNOS, { xi.item.ARMORED_DRAGONHORN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.ARMORED_DRAGONHORN })
end

return entity
