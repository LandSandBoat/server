-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_megantereon (???)
-- Spawns Megantereon
-- !pos -764 -8 121 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MEGANTEREON, { xi.item.GARGANTUAN_BLACK_TIGER_FANG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.GARGANTUAN_BLACK_TIGER_FANG })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
