-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_ironclad_smiter (???)
-- Spawns Ironclad Smiter
-- !pos -744 -17 -696 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IRONCLAD_SMITER, { xi.item.VIAL_OF_TABLILLA_MERCURY, xi.item.SMOLDERING_ARM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.VIAL_OF_TABLILLA_MERCURY, xi.item.SMOLDERING_ARM })
end

return entity
