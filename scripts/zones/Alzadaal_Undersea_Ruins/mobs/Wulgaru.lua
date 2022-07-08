-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Wulgaru
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- Todo: Pups can make it change frames, Overload causes Rage

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.SLEEPRES, 10000)
    mob:addMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:addMod(xi.mod.ATT, 25)
    mob:addMod(xi.mod.MDEF, 50)
    mob:addMod(xi.mod.DEF, 25)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 10)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
    mob:addStatusEffect(xi.effect.REGAIN, 2, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setAnimationSub(0)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.EARTH_MEVA, 25)
    mob:setMod(xi.mod.DARK_MEVA, 25)
    mob:setMod(xi.mod.LIGHT_MEVA, 25)
    mob:setMod(xi.mod.FIRE_MEVA, 25)
    mob:setMod(xi.mod.WATER_MEVA, 25)
    mob:setMod(xi.mod.THUNDER_MEVA, 25)
    mob:setMod(xi.mod.ICE_MEVA, 25)
    mob:setMod(xi.mod.WIND_MEVA, 25)
    mob:setMod(xi.mod.EARTH_SDT, 25)
    mob:setMod(xi.mod.DARK_SDT, 25)
    mob:setMod(xi.mod.LIGHT_SDT, 25)
    mob:setMod(xi.mod.FIRE_SDT, 25)
    mob:setMod(xi.mod.WATER_SDT, 25)
    mob:setMod(xi.mod.THUNDER_SDT, 25)
    mob:setMod(xi.mod.ICE_SDT, 25)
    mob:setMod(xi.mod.WIND_SDT, 25)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.PARALYZERES, 100)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, isKiller)
end
return entity
