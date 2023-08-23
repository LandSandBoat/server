-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_maahes (???)
-- Spawns Maahes
-- !pos 214.107 19.970 -93.816 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MAAHES, { xi.item.COEURL_ROUND })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.COEURL_ROUND })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
