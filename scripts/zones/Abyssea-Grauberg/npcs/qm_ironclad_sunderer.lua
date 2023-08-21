-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_ironclad_sunderer (???)
-- Spawns Ironclad Sunderer
-- !pos 501 25 503 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IRONCLAD_SUNDERER, { xi.item.TEEKESSELCHEN_FRAGMENT, xi.item.DARKFLAME_ARM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.TEEKESSELCHEN_FRAGMENT, xi.item.DARKFLAME_ARM })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
