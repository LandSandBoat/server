-----------------------------------
-- Area: Horlais Peak
--  Mob: Helltail Harry
-- BCNM: Tails of Woe
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEP_MEVA, 1000)
    mob:setMod(xi.mod.SILENCE_MEVA, 900)
    mob:setMod(xi.mod.LULLABY_MEVA, 700)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
