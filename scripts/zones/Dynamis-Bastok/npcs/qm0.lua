-----------------------------------
-- Area: Dynamis-Bastok
--  NPC: ??? (qm0)
-- Note: Spawns Gu'Dha Effigy / Arch Gu'Dha Effigy
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
