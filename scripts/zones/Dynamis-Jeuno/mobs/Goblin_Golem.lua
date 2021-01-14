-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Goblin Golem
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
end

return entity
