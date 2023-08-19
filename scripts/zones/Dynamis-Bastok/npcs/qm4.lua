-----------------------------------
-- Area: Dynamis-Bastok
--  NPC: ??? (qm4)
-- Note: Spawns Bu'Bho Truesteel
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
