-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm7)
-- Note: Spawns Animated Longsword
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
