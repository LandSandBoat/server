-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_hexenpilz (???)
-- Spawns Hexenpilz
-- !pos -182.000 2.858 32.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.HEXENPILZ, { xi.item.OBLIVISPORE_MUSHROOM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.OBLIVISPORE_MUSHROOM })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
