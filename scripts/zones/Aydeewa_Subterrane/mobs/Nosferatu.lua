-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Nosferatu
--  Mobid: 17056157
-----------------------------------
mixins = {require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
-----------------------------------
local entity = {}
entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.MDEF, 30)
    mob:addMod(xi.mod.DEF, 50)
    mob:setMod(xi.mod.EARTH_MEVA, 250)
    mob:setMod(xi.mod.DARK_MEVA, 300)
    mob:setMod(xi.mod.FIRE_MEVA, 250)
    mob:setMod(xi.mod.WATER_MEVA, 250)
    mob:setMod(xi.mod.THUNDER_MEVA, 250)
    mob:setMod(xi.mod.ICE_MEVA, 250)
    mob:setMod(xi.mod.WIND_MEVA, 250)
    mob:setMod(xi.mod.EARTH_SDT, 250)
    mob:setMod(xi.mod.DARK_SDT, 300)
    mob:setMod(xi.mod.FIRE_SDT, 250)
    mob:setMod(xi.mod.WATER_SDT, 250)
    mob:setMod(xi.mod.THUNDER_SDT, 250)
    mob:setMod(xi.mod.ICE_SDT, 250)
    mob:setMod(xi.mod.WIND_SDT, 250)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.DARK_ABSORB, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:addMod(xi.mod.MOVE, 12)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.DREAD_SPIKES, 5, 0, 9000000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    xi.mix.jobSpecial.config(mob, {specials =
    {{id = xi.jsa.ASTRAL_FLOW, hpp = math.random(66, 95)},
    {id = xi.jsa.BLOOD_WEAPON, hpp = 25},},})
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
