-----------------------------------
-- Area: Dynamis-Windurst
--  NPC: ??? (qm3)
-- Note: Spawns Naa Yixo the Stillrage
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
