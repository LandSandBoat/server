-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_sharabha (???)
-- Spawns Sharabha
-- !pos -314 0 308 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SHARABHA, { xi.item.SAND_CAKED_FANG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.SAND_CAKED_FANG })
end

return entity
