-----------------------------------
-- Area: Horlais Peak
--  Mob: Huntfly
-- BCNM: Dropping Like Flies
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobEngaged = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
