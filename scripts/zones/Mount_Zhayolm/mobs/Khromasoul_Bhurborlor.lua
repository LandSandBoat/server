-----------------------------------
-- Area: Mount Z
--  ZNM: Khromasoul Bhurborlor
--  Mobid: 17027474
-----------------------------------
mixins ={require("scripts/mixins/job_special"),
         require("scripts/mixins/rage")}
-----------------------------------
local entity = {}
entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.ATT, 40)
    mob:addMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.DEF, 40)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 25)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 70)
    mob:addMod(xi.mod.INT, 30)
    mob:addMod(xi.mod.MND, 40)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 30)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 300)
    mob:setMod(xi.mod.DARK_MEVA, 250)
    mob:setMod(xi.mod.LIGHT_MEVA, 250)
    mob:setMod(xi.mod.FIRE_MEVA, 250)
    mob:setMod(xi.mod.THUNDER_MEVA, 300)
    mob:setMod(xi.mod.ICE_MEVA, 250)
    mob:setMod(xi.mod.WIND_MEVA, 250)
    mob:setMod(xi.mod.EARTH_SDT, 300)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 250)
    mob:setMod(xi.mod.FIRE_SDT, 250)
    mob:setMod(xi.mod.THUNDER_SDT, 300)
    mob:setMod(xi.mod.ICE_SDT, 250)
    mob:setMod(xi.mod.WIND_SDT, 250)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.LTNG_ABSORB, 100)
    mob:setMod(xi.mod.EARTH_ABSORB, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.FASTCAST, 500)
    mob:setMobMod(xi.mobMod.LINK_RADIUS, 500)
    mob:setMobMod(xi.mobMod.SUPERLINK, mob:getTargID())
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.HASTE_MAGIC, 26)
    mob:addMod(xi.mod.CURE_POTENCY, 150)
    mob:addMod(xi.mod.CURE_CAST_TIME, 50)
    mob:addMod(xi.mod.MOVE, 12)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addStatusEffect(xi.effect.REPRISAL, 10, 0, 9000000)
    mob:addStatusEffect(xi.effect.PHALANX, 10, 0, 9000000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setAnimationSub(0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.INVINCIBLE, hpp = 100},
            {id = xi.jsa.INVINCIBLE, hpp = 75},
            {id = xi.jsa.INVINCIBLE, hpp = 50},
            {id = xi.jsa.INVINCIBLE, hpp = 25},
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
