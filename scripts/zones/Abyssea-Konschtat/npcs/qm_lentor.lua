-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_lentor (???)
-- Spawns Lentor
-- !pos -248.000 47.971 403.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.LENTOR, { xi.item.GIANT_SLUG_EYESTALK })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.GIANT_SLUG_EYESTALK })
end

return entity
