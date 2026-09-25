-----------------------------------
-- Area: Yhoator Jungle (124)
--   NM: Woodland Sage
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMaxMP(0) -- WHM but has no MP
end

entity.onMobDespawn = function(mob)
    -- Set Woodland_Sage's spawnpoint and respawn time (21-24 hours)
    mob:setRespawnTime(math.randomInt(75600, 86400))
end

return entity
