-----------------------------------
-- Area: Caedarva Mire
--  ZNM: Tyger
-- !pos -766 -12 632 79
-- Spawn with Singed Buffalo: !additem 2593
-----------------------------------
mixins = {require("scripts/mixins/rage")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:addMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.SLOWRES, 10000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.MDEF, 20)
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.STR, 20)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.INT, 20)
    mob:addMod(xi.mod.MND, 20)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.DARK_MEVA, 250)
    mob:setMod(xi.mod.LIGHT_MEVA, 128)
    mob:setMod(xi.mod.FIRE_MEVA, 170)
    mob:setMod(xi.mod.WATER_MEVA, 170)
    mob:setMod(xi.mod.THUNDER_MEVA, 250)
    mob:setMod(xi.mod.WIND_MEVA, 170)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 128)
    mob:setMod(xi.mod.FIRE_SDT, 170)
    mob:setMod(xi.mod.WATER_SDT, 170)
    mob:setMod(xi.mod.THUNDER_SDT, 250)
    mob:setMod(xi.mod.WIND_SDT, 170)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.LTNG_ABSORB, 100)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setAnimationSub(0)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
