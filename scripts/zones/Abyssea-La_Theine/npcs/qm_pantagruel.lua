-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_pantagruel (???)
-- Spawns Pantagruel
-- !pos -356 8 163 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.PANTAGRUEL, { xi.item.OVERSIZED_SOCK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.OVERSIZED_SOCK })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
