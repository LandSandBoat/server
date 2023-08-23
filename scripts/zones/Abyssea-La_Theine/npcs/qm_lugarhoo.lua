-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_lugarhoo (???)
-- Spawns Lugarhoo
-- !pos -85 24 -513 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LUGARHOO, { xi.item.FILTHY_GNOLE_CLAW })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.FILTHY_GNOLE_CLAW })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
