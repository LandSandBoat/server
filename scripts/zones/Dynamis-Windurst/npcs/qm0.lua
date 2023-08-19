-----------------------------------
-- Area: Dynamis-Windurst
--  NPC: ??? (qm0)
-- Note: Spawns Tzee Xicu Idol / Arch Tzee Xicu Idol
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
