-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_lorelei (???)
-- Spawns Lorelei
-- !pos -192 -31 480 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LORELEI, { xi.item.FAY_TEARDROP })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.FAY_TEARDROP })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
