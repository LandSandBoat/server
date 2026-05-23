-----------------------------------
-- Area: Al Zahbi
--  Mob: General Najelith
--  Besieged
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.besieged.onAllyInitialize(mob)
end

entity.onMobSpawn = function(mob)
    xi.besieged.onAllySpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.besieged.onAllyDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.besieged.onAllyDespawn(mob)
end

return entity
