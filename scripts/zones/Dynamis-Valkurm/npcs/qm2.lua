-----------------------------------
-- Area: Dynamis-Valkurm
--  NPC: ??? (qm2)
-- Note: Spawns Lost Fairy Ring
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
