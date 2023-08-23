-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_chickcharney (???)
-- Spawns Chickcharney
-- !pos 36 0 -240 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.CHICKCHARNEY, { xi.item.HIGH_QUALITY_COCKATRICE_SKIN  })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.HIGH_QUALITY_COCKATRICE_SKIN  })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
