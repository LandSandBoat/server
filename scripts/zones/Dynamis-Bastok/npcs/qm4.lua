-----------------------------------
-- Area: Dynamis-Bastok
--  NPC: ??? (qm4)
-- Note: Spawns Bu'Bho Truesteel
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
