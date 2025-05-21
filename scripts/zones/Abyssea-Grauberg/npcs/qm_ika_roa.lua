-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_ika_roa (???)
-- Spawns Ika-Roa
-- !pos 158 -29 -215 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IKA_ROA, { xi.item.HIGH_QUALITY_PUGIL_SCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.HIGH_QUALITY_PUGIL_SCALE })
end

return entity
