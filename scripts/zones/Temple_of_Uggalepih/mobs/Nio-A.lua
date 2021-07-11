-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Nio-A
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
    mob:addMod(xi.mod.SLEEPRES, 50)
    mob:addMod(xi.mod.LULLABYRES, 50)
    mob:addMod(xi.mod.STUNRES, 50)
    mob:addMod(xi.mod.DMGMAGIC, 80)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
