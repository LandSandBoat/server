-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_granite_borer (???)
-- Spawns Granite Borer
-- !pos 401.489 19.730 -282.864 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.GRANITE_BORER, { xi.item.WITHERED_COCOON })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.WITHERED_COCOON })
end

return entity
