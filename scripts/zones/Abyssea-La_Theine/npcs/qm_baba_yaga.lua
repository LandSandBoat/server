-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_baba_yaga (???)
-- Spawns Baba Yaga
-- !pos -74 18 137 132
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_LA_THEINE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BABA_YAGA, { xi.item.PICEOUS_SCALE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.PICEOUS_SCALE })
end

return entity
