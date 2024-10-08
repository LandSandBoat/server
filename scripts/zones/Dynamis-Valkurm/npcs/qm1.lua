-----------------------------------
-- Area: Dynamis-Valkurm
--  NPC: ??? (qm1)
-- Note: Spawns Lost Nant'ina
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
