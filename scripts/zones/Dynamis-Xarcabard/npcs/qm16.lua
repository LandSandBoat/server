-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm16)
-- Note: Spawns Animated Staff
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
