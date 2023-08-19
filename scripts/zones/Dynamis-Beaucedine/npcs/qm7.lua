-----------------------------------
-- Area: Dynamis-Beaucedine
--  NPC: ??? (qm7)
-- Note: Spawns Mildaunegeux
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
