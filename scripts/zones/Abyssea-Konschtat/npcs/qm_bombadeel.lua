-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_bombadeel (???)
-- Spawns Bombadeel
-- !pos -358.000 8.000 -42.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BOMBADEEL, { xi.item.CLUMP_OF_SNAKESKIN_MOSS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.CLUMP_OF_SNAKESKIN_MOSS })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
