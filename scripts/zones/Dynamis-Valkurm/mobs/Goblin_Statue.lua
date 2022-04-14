-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Goblin Statue
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
