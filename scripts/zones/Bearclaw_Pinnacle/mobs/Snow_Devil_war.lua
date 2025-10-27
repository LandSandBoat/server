-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Snow Devil (WAR)
-- ENM: When Hell Freezes Over
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 60)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 60)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 15)
    mob:setMod(xi.mod.REGAIN, 50)
end

return entity
