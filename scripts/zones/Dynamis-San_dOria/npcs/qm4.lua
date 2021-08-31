-----------------------------------
-- Area: Dynamis-San_dOria
--  NPC: ??? (qm4)
-- Note: Spawns Spellspear Djokvukk
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
