-----------------------------------
-- Area: Horlais Peak
--  Mob: Huntfly
-- BCNM: Dropping Like Flies
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.SLEEP_MEVA, 1000)
    mob:setMod(xi.mod.LULLABY_MEVA, 1000)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
