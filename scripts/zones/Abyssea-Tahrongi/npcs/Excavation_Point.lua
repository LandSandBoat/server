-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Excavation Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.EXCAVATION, 510)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.EXCAVATION)
end

return entity
