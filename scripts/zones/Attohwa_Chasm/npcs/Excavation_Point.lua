-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Excavation Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.EXCAVATION, 10)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.EXCAVATION)
end

return entity
