-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Goblin Statue
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
