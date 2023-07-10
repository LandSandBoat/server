-----------------------------------
-- Area: Caedarva Mire
--  ZNM: Mahjlaef
--  Mobid: 17101204
-----------------------------------
mixins ={require("scripts/mixins/job_special"),
         require("scripts/mixins/rage")}
-----------------------------------
local entity = {}
entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 25)
    mob:addMod(xi.mod.STR, 40)
    mob:addMod(xi.mod.VIT, 30)
    mob:addMod(xi.mod.INT, 30)
    mob:addMod(xi.mod.MND, 30)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 30)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 200)
    mob:setMod(xi.mod.FIRE_MEVA, 200)
    mob:setMod(xi.mod.WATER_MEVA, 300)
    mob:setMod(xi.mod.ICE_MEVA, 200)
    mob:setMod(xi.mod.WIND_MEVA, 200)
    mob:setMod(xi.mod.EARTH_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 200)
    mob:setMod(xi.mod.WATER_SDT, 300)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.WIND_SDT, 200)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.FASTCAST, 50)
    mob:addMod(xi.mod.MACC, 25)
    mob:addMod(xi.mod.MOVE, 12)
    mob:addMod(xi.mod.HASTE_MAGIC, 2600)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 10, 0, 9000000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setAnimationSub(0)
end

entity.onAdditionalEffect = function(mob, target, damage)
 return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, {chance = 25, power = math.random(5, 20)})
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MANAFONT, hpp = 100},
            {id = xi.jsa.MANAFONT, hpp = 75},
            {id = xi.jsa.MANAFONT, hpp = 50},
            {id = xi.jsa.MANAFONT, hpp = 25},
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
