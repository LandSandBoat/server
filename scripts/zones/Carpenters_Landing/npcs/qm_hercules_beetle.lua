-----------------------------------
-- Area: Carpenters' Landing (2)
--  NPC: ???
-- Note: Spawns Hercules Beetle
-----------------------------------
local func = require('scripts/zones/Carpenters_Landing/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    func.herculesTreeOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.herculesTreeOnTrigger(player, npc)
end

return entity
