-----------------------------------
-- Area: Carpenters' Landing (2)
--  NPC: ???
-- Note: Spawns Hercules Beetle
-----------------------------------
local func = require("scripts/zones/Carpenters_Landing/globals")
-----------------------------------

function onTrade(player, npc, trade)
    func.herculesTreeOnTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.herculesTreeOnTrigger(player, npc)
end
