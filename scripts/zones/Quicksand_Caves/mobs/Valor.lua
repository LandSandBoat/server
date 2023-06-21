-----------------------------------
-- Area: Quicksand Caves
--  Mob: Valor
-- Coming of Age (San dOria Mission 8-1)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
    mob:addMod(xi.mod.SLEEP_MEVA, 50)
    mob:addMod(xi.mod.LULLABY_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
