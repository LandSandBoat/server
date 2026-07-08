-----------------------------------
-- Area: Pashow Marshlands
-- NPC: QM_PEPPER
-- Involved In Mission: Let Sleeping Dogs Lie
-- !pos -429.603 24.760 473.015
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.HARVESTING, 12)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.HARVESTING)
end

return entity
