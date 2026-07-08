-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_gaizkin (???)
-- Spawns Gaizkin
-- !pos -132.253 0.015 0.753 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GAIZKIN, { xi.item.VIAL_OF_UNDYING_OOZE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.VIAL_OF_UNDYING_OOZE })
end

return entity
