-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Verdelet
-- !pos 417 -19.3 -70 79
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- TODO INITIAL COMMIT Just put here so players cannot run through the NM's 
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.MDEF, 50)
    mob:addMod(xi.mod.DEF, 25)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 10)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
    mob:setMod(xi.mod.EARTH_RES, 25)
    mob:setMod(xi.mod.DARK_RES, 25)
    mob:setMod(xi.mod.LIGHT_RES, 25)
    mob:setMod(xi.mod.FIRE_RES, 25)
    mob:setMod(xi.mod.WATER_RES, 25)
    mob:setMod(xi.mod.THUNDER_RES, 25)
    mob:setMod(xi.mod.ICE_RES, 25)
    mob:setMod(xi.mod.WIND_RES, 25)
    mob:setMod(xi.mod.EARTH_SDT, 25)
    mob:setMod(xi.mod.DARK_SDT, 25)
    mob:setMod(xi.mod.LIGHT_SDT, 25)
    mob:setMod(xi.mod.FIRE_SDT, 25)
    mob:setMod(xi.mod.WATER_SDT, 25)
    mob:setMod(xi.mod.THUNDER_SDT, 25)
    mob:setMod(xi.mod.ICE_SDT, 25)
    mob:setMod(xi.mod.WIND_SDT, 25)
    mob:setMod(xi.mod.DARK_RES, 250)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.SILENCERES, 150)
    mob:setMod(xi.mod.STUNRES, 5)
    mob:setMod(xi.mod.BINDRES, 5)
    mob:setMod(xi.mod.GRAVITYRES, 150)
    mob:setMod(xi.mod.SLEEPRES, 150)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 2, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 5, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setAnimationSub(0)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
