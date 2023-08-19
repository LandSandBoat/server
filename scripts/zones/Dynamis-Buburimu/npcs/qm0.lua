-----------------------------------
-- Area: Dynamis-Buburimu
--  NPC: ??? (qm0)
-- Note: Spawns Apocalyptic Beast / Arch Apocalyptic Beast
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
