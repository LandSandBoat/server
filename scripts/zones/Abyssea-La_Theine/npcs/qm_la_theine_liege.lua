-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_la_theine_liege (???)
-- Spawns La Theine Liege
-- !pos 80 15 199 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LA_THEINE_LIEGE, { xi.item.TRANSPARENT_INSECT_WING })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.TRANSPARENT_INSECT_WING })
end

return entity
