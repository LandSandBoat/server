-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Armed Gears
-- !pos -19 -4 -153
-----------------------------------
-- todo
-- add add random elemental magic absorb to elements its casting
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/families/gears")
}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.MDEF, 150)
    mob:addMod(xi.mod.DEF, 100)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.INT, 50)
    mob:addMod(xi.mod.MND, 20)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DEFP, 0)
    mob:addMod(xi.mod.DEFP, 475)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_RES, 170)
    mob:setMod(xi.mod.DARK_RES, 250)
    mob:setMod(xi.mod.LIGHT_RES, 128)
    mob:setMod(xi.mod.FIRE_RES, 170)
    mob:setMod(xi.mod.WATER_RES, 170)
    mob:setMod(xi.mod.THUNDER_RES, 170)
    mob:setMod(xi.mod.ICE_RES, 200)
    mob:setMod(xi.mod.WIND_RES, 170)
	mob:setMod(xi.mod.EARTH_SDT, 170)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 128)
    mob:setMod(xi.mod.FIRE_SDT, 170)
    mob:setMod(xi.mod.WATER_SDT, 170)
    mob:setMod(xi.mod.THUNDER_SDT, 170)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.WIND_SDT, 170)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.FIRE_ABSORB, 100)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 10, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
