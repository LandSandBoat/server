-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Shadow
-- !pos -106.600 -5.000 -81.149 235
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
