-----------------------------------
-- Area: Lower Jeuno
--  NPC: Synergy Furnace
-----------------------------------
require("scripts/globals/synergy_furnace")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.synergyFurnace.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.synergyFurnace.onTrigger(player)
end

return entity
