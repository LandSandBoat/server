-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_burstrox_powderpate (???)
-- Spawns Burstrox Powderpate
-- !pos 396 40 -436 254
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_GRAUBERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BURSTROX_POWDERPATE, { xi.item.LENGTH_OF_GOBLIN_ROPE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.item.LENGTH_OF_GOBLIN_ROPE })
end

return entity
