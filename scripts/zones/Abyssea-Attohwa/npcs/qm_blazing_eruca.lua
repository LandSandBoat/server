-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_blazing_eruca (???)
-- Spawns Blazing Eruca
-- !pos 233.162 19.720 -243.255 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BLAZING_ERUCA, { xi.item.ERUCA_EGG })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.ERUCA_EGG })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
