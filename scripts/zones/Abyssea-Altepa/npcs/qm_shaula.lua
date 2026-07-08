-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_shaula (???)
-- Spawns Shaula
-- !pos -71 0 408 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SHAULA, { xi.item.VIAL_OF_VADLEANY_FLUID, xi.item.HIGH_QUALITY_SCORPION_CLAW })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.VIAL_OF_VADLEANY_FLUID, xi.item.HIGH_QUALITY_SCORPION_CLAW })
end

return entity
