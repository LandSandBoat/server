-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_abas (???)
-- Spawns Abas
-- !pos 407 -16 -397 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ABAS, { xi.item.EFT_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.EFT_EGG })
end

return entity
