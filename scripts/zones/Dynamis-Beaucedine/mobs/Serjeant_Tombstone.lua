-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Serjeant Tombstone
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    dynamis.refillStatueOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.refillStatueOnDeath(mob, player, isKiller)
end

return entity
