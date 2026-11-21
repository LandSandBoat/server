-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Ghost
-- !pos 135.3171 0.0000 130.4728 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    xi.events.harvestFestival.onRoamerTrigger(player, npc)
end

entity.onPathComplete = function(npc)
    xi.events.harvestFestival.onRoamerPathComplete(npc)
end

return entity
