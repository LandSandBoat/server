-----------------------------------
-- Area: Dynamis-Windurst
--  NPC: ??? (qm3)
-- Note: Spawns Naa Yixo the Stillrage
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
