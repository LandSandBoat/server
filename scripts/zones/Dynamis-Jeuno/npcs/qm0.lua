-----------------------------------
-- Area: Dynamis-Jeuno
--  NPC: ??? (qm0)
-- Note: Spawns Goblin Golem / Arch Goblin Golem
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
