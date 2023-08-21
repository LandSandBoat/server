-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_berstuk (???)
-- Spawns Berstuk
-- !pos -280.000 -4.000 -38.516 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BERSTUK, { xi.item.EXTENDED_EYESTALK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.EXTENDED_EYESTALK })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
