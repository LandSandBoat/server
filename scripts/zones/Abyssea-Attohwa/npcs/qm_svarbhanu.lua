-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_svarbhanu (???)
-- Spawns Svarbhanu
-- !pos -545.043 -12.410 -72.175 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SVARBHANU, { xi.item.CRACKED_DRAGONSCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.CRACKED_DRAGONSCALE })
end

return entity
