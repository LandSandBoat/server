-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_amarok (???)
-- Spawns Amarok
-- !pos -558 0 161 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.AMAROK, { xi.item.SHARABHA_HIDE, xi.item.TIGER_KINGS_HIDE, xi.item.HIGH_QUALITY_DHALMEL_HIDE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.SHARABHA_HIDE, xi.item.TIGER_KINGS_HIDE, xi.item.HIGH_QUALITY_DHALMEL_HIDE })
end

return entity
