-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Ghost
-- !pos -95.750 -2.367 50.100 238
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
