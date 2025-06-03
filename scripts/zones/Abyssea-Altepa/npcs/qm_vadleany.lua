-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_vadleany (???)
-- Spawns Vadleany
-- !pos -56 1 123 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.VADLEANY, { xi.item.LADYBIRD_LEAF })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.LADYBIRD_LEAF })
end

return entity
