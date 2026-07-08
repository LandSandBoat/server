-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_pallid_percy (???)
-- Spawns Pallid Percy
-- !pos 281.063 20.376 174.011 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PALLID_PERCY, { xi.item.VIAL_OF_UNDYING_OOZE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.VIAL_OF_UNDYING_OOZE })
end

return entity
