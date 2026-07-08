-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_arimaspi (???)
-- Spawns Arimaspi
-- !pos 438.000 31.922 358.000 15
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_KONSCHTAT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.ARIMASPI, { xi.item.CLOUDED_LENS })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.CLOUDED_LENS })
end

return entity
