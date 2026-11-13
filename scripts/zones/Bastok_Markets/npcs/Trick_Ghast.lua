-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Ghast
-- !pos -311.333 -14.733 -63.516 235
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
