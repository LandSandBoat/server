-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm20)
-- Note: Spawns Animated Shield
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
