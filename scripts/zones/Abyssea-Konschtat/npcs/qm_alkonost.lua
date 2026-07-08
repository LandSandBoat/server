-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_alkonost (???)
-- Spawns Alkonost
-- !pos 54.000 30.654 414.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ALKONOST, { xi.item.GIANT_BUGARD_TUSK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.GIANT_BUGARD_TUSK })
end

return entity
