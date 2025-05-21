-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_siranpa-kamuy (???)
-- Spawns Siranpa-Kamuy
-- !pos 370.000 1.601 10.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.SIRANPA_KAMUY, { xi.item.ROTTING_EYEBALL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.ROTTING_EYEBALL })
end

return entity
