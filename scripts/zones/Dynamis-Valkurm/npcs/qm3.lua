-----------------------------------
-- Area: Dynamis-Valkurm
--  NPC: ??? (qm3)
-- Note: Spawns Lost Stcemqestcint
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
