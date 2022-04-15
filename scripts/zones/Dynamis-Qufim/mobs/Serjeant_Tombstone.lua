-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Serjeant Tombstone
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.refillStatueOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.dynamis.refillStatueOnDeath(mob, player, isKiller)
end

return entity
