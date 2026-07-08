-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_wherwetrice (???)
-- Spawns Wherwetrice
-- !pos 198.045 20.122 108.705 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.WHERWETRICE, { xi.item.MANGLED_COCKATRICE_SKIN })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.MANGLED_COCKATRICE_SKIN })
end

return entity
