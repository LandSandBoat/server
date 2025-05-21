-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_cannered_noz (???)
-- Spawns Cannered Noz
-- !pos -355 4 251 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CANNERED_NOZ, { xi.item.BALEFUL_SKULL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.BALEFUL_SKULL })
end

return entity
