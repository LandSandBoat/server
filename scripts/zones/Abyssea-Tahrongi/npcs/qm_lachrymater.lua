-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_lachrymater (???)
-- Spawns Lachrymater
-- !pos -220 -1 -299 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LACHRYMATER, { xi.item.MOANING_VESTIGE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.MOANING_VESTIGE })
end

return entity
