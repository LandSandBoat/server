-----------------------------------
-- Area: Dynamis-San_dOria
--  NPC: ??? (qm3)
-- Note: Spawns Bloodfist Voshgrosh
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
