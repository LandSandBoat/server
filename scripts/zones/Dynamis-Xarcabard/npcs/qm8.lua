-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm8)
-- Note: Spawns Animated Claymore
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
