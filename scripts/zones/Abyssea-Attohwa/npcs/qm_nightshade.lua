-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_nightshade (???)
-- Spawns Nightshade
-- !pos 410.304 19.500 13.227 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.NIGHTSHADE, { xi.item.WITHERED_BUD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.WITHERED_BUD })
end

return entity
