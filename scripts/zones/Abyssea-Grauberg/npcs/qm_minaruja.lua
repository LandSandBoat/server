-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_minaruja (???)
-- Spawns Minaruja
-- !pos 340 -15 -116 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.MINARUJA, { xi.item.PURSUERS_WING })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.PURSUERS_WING })
end

return entity
