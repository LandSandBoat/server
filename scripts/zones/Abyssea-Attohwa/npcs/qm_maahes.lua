-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_maahes (???)
-- Spawns Maahes
-- !pos 214.107 19.970 -93.816 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MAAHES, { xi.item.COEURL_ROUND })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.COEURL_ROUND })
end

return entity
