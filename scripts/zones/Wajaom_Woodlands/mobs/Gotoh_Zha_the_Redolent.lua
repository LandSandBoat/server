-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Gotoh Zha the Redolent
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rage')
}
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
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, hpp = math.random(66, 95) },
            { id = xi.jsa.BENEDICTION, hpp = 0 },
        },
    })

    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setSpellList(296) -- Set BLM spell list
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 1 and mob:getLocalVar('jobChanged') == 0 then
        mob:setLocalVar('jobChanged', 1)
        mob:setSpellList(297) -- Set WHM spell list.
        -- set new JSA parameters
        xi.mix.jobSpecial.config(mob, {
            specials =
            {
                { id = xi.jsa.MANAFONT, hpp = 0 },
                { id = xi.jsa.BENEDICTION, hpp = math.random(25, 50) },
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
end

entity.onMobDeath = function(mob, killer)
end

return entity
