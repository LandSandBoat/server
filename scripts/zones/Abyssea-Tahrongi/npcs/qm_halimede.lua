-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_halimede (???)
-- Spawns Halimede
-- !pos -234 15 -603 45
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_TAHRONGI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.HALIMEDE, { xi.item.HIGH_QUALITY_CLIONID_WING })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.HIGH_QUALITY_CLIONID_WING })
end

return entity
