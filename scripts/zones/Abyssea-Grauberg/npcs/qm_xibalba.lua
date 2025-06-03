-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_xibalba (???)
-- Spawns Xibalba
-- !pos -487 -168 211 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.XIBALBA, { xi.item.DECAYING_MOLAR })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.DECAYING_MOLAR })
end

return entity
