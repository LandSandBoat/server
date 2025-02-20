-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_bugul_noz (???)
-- Spawns Bugul Noz
-- !pos -608 -1 -397 218
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ALTEPA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BUGUL_NOZ, { xi.item.HANDFUL_OF_SABULOUS_CLAY })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.HANDFUL_OF_SABULOUS_CLAY })
end

return entity
