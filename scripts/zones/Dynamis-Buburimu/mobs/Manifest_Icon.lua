-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Manifest Icon
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
