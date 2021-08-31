-----------------------------------
-- Area: Dynamis-Windurst
--  NPC: ??? (qm0)
-- Note: Spawns Tzee Xicu Idol / Arch Tzee Xicu Idol
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
