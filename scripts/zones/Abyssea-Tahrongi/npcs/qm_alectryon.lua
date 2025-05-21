-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_alectryon (???)
-- Spawns Alectryon
-- !pos -42 -8 34 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ALECTRYON, { xi.item.CHUNK_OF_COCKATRICE_TAILMEAT, xi.item.QUIVERING_EFT_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.CHUNK_OF_COCKATRICE_TAILMEAT, xi.item.QUIVERING_EFT_EGG })
end

return entity
