-----------------------------------
-- Area: Mamook
--   NM: Iriri Samariri (T2 ZNM)
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- TODO INITIAL COMMIT Just put here so players cannot run through the NM's 
entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.SLEEPRES, 10000)
    mob:addMod(xi.mod.BINDRES, 10000)
    mob:addMod(xi.mod.ATT, 25)
    mob:addMod(xi.mod.MDEF, 50)
    mob:addMod(xi.mod.DEF, 25)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 10)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
    mob:addStatusEffect(xi.effect.REGAIN, 2, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 10, 3, 0)
    mob:setMod(xi.mod.LULLABYRES, 10000)
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
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity