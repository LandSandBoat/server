-----------------------------------
-- Area: Dynamis-Valkurm
--  NPC: ??? (qm0)
-- Note: Spawns Cirrate Christelle / Arch Christelle
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
