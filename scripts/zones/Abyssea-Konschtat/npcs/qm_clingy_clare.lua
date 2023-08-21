-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_clingy_clare (???)
-- Spawns Clingy Clare
-- !pos 150.000 17.601 90.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CLINGY_CLARE, { xi.item.TINY_MORBOL_VINE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.TINY_MORBOL_VINE })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
