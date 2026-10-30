-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Specter
-- !pos -34.000 -7.800 -73.266 235
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
