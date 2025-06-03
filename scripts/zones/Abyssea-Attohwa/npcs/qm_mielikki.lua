-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_mielikki (???)
-- Spawns Mielikki
-- !pos 481.096 20.000 39.549 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MIELIKKI, { xi.item.GREAT_ROOT })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.GREAT_ROOT })
end

return entity
