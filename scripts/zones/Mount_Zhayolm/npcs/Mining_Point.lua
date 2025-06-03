-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Mining Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.MINING, 153)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.MINING)
end

return entity
