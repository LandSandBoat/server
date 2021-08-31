-----------------------------------
-- Area: Dynamis-Qufim
--  NPC: ??? (qm0)
-- Note: Spawns Antaeus / Arch Antaeus
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
