-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Dea
-- Mobid: 16990507
-----------------------------------
mixins ={require("scripts/mixins/job_special"),
         require("scripts/mixins/rage")}
-----------------------------------
local entity = {}
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMod(xi.mod.CRITHITRATE, 50)
    mob:setMod(xi.mod.CRIT_DMG_INCREASE, 50)
    mob:addMod(xi.mod.MDEF, 25)
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 25)
    mob:addMod(xi.mod.STR, 20)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.INT, 50)
    mob:addMod(xi.mod.MND, 20)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:addMod(xi.mod.DEX, 60)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.EARTH_MEVA, 300)
    mob:setMod(xi.mod.DARK_MEVA, 250)
    mob:setMod(xi.mod.LIGHT_MEVA, 250)
    mob:setMod(xi.mod.FIRE_MEVA, 250)
    mob:setMod(xi.mod.WATER_MEVA, 250)
    mob:setMod(xi.mod.THUNDER_MEVA, 250)
    mob:setMod(xi.mod.EARTH_SDT, 300)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 250)
    mob:setMod(xi.mod.FIRE_SDT, 250)
    mob:setMod(xi.mod.WATER_SDT, 250)
    mob:setMod(xi.mod.THUNDER_SDT, 250)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.EARTH_ABSORB, 100)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setAnimationSub(0)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MIGHTY_STRIKES, hpp = 100},
            {id = xi.jsa.MIGHTY_STRIKES, hpp = 75},
            {id = xi.jsa.MIGHTY_STRIKES, hpp = 50},
            {id = xi.jsa.MIGHTY_STRIKES, hpp = 25},
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
