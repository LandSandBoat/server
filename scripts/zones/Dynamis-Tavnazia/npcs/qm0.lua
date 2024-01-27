-----------------------------------
-- Area: Dynamis-Tavnazia
--  NPC: ??? (qm0)
-- Note: Spawns Diabolos [Spade|Heart|Diamond|Club] / Diabolos [Somnus|Nox|Umbra|Letum]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
