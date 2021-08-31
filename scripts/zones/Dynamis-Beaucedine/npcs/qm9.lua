-----------------------------------
-- Area: Dynamis-Beaucedine
--  NPC: ??? (qm9)
-- Note: Spawns Dagourmarche
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    dynamis.qmOnTrigger(player, npc)
end

return entity
