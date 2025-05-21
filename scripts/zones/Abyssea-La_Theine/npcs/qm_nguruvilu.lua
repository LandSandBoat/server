-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_nguruvilu (???)
-- Spawns Nguruvilu
-- !pos 311 23 -524 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NGURUVILU, { xi.item.WINTER_PUK_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.WINTER_PUK_EGG })
end

return entity
