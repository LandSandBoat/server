-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_emperador_de_altepa (???)
-- Spawns Emperor de Altepa
-- !pos -491 0 -611 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.EMPERADOR_DE_ALTEPA, { xi.item.BOTTLE_OF_OASIS_WATER, xi.item.SPRIG_OF_GIANT_MISTLETOE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.BOTTLE_OF_OASIS_WATER, xi.item.SPRIG_OF_GIANT_MISTLETOE })
end

return entity
