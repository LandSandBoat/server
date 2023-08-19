-----------------------------------
-- Area: Dynamis-Buburimu
--  NPC: ??? (qm2)
-- Note: Spawns Lost Barong
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
