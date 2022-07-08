-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Gotoh Zha the Redolent
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/status")
-----------------------------------
-- Detailed Notes & Todos
-- (please remove these if you handle any)
-- 1. Find out if stats (INT, MND, MAB..)
--    actually change when it switches mode on retail.
-- 2. Correct mobskill use behavior:
--    Will always do Groundburst after Warm-Up,
--    will never use Groundburst without a preceding Warm-Up.
--    will not attempt any other TP attacks until Groundburst finished
--    (either landed or failed from lack of targets, resetting his TP)
-- 3. Firespit can land over 1500 dmg during rage.
--    If rage is reset/removed its 2hrs are also reset.
-- 4. This NM also shows some insight into retail mob 2hrs/1hrs:
--    they actually have the same cooldown as players and only
--    time, respawn, or rage loss will reset them.
-- 6. Speaking of those two functions..
--    We have no data on the weapon break chance, went with 10% on both for now.
--    Do crit ws hits count differently than regular ws hits on retail?
--    Should onCriticalHit count WS crit hits if regular WS hits do not count?
-----------------------------------
local entity = {}
-- TODO INITIAL COMMIT Just put here so players cannot run through the NM's 
entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 30)
    mob:addMod(xi.mod.BINDRES, 30)
    mob:addMod(xi.mod.GRAVITYRES, 30)
    mob:addMod(xi.mod.ATT, 200)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
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
    mob:setMod(xi.mod.DEFP, 50)
    mob:addMod(xi.mod.DEFP, 475)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 170)
    mob:setMod(xi.mod.DARK_MEVA, 250)
    mob:setMod(xi.mod.LIGHT_MEVA, 128)
    mob:setMod(xi.mod.FIRE_MEVA, 170)
    mob:setMod(xi.mod.WATER_MEVA, 170)
    mob:setMod(xi.mod.THUNDER_MEVA, 170)
    mob:setMod(xi.mod.ICE_MEVA, 200)
    mob:setMod(xi.mod.WIND_MEVA, 170)
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
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MANAFONT, hpp = math.random(66, 95)},
            {id = xi.jsa.BENEDICTION, hpp = 0},
        },
    })

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setSpellList(296) -- Set BLM spell list
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 1 and mob:getLocalVar("jobChanged") == 0 then
        mob:setLocalVar("jobChanged", 1)
        mob:setSpellList(297) -- Set WHM spell list.
        -- set new JSA parameters
        xi.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = xi.jsa.MANAFONT, hpp = 0},
                {id = xi.jsa.BENEDICTION, hpp = math.random(25, 50)},
            },
        })
    end
end

entity.onCriticalHit = function(mob)
    local randVal = math.random(1, 100)

    if mob:getAnimationSub() == 0 and randVal <= 10 then
        mob:setAnimationSub(1)
    end
end

entity.onWeaponskillHit = function(mob, attacker, weaponskill)
    local randVal = math.random(1, 100)

    if mob:getAnimationSub() == 0 and randVal <= 10 then
        mob:setAnimationSub(1)
    end

    return 0
end

entity.onMobDeath = function(mob, killer)
end

return entity
