-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Serjeant Tombstone
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    dynamis.refillStatueOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.refillStatueOnDeath(mob, player, isKiller)
end

return entity
