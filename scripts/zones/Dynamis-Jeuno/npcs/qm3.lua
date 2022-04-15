-----------------------------------
-- Area: Dynamis-Jeuno
--  NPC: ??? (qm3)
-- Note: Spawns Scourquix Scaleskin
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
