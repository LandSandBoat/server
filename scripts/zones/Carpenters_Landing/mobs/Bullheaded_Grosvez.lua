-----------------------------------
--  Area: Carpenters' Landing
--    NM: Bullheaded Grosvez
-- Quest: Behind the Smile
-- !pos 39.877, -7.397, -565.422 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("startTriple", 1) -- Triple JA is enabled
    mob:setLocalVar("pause", 0)
    mob:setLocalVar("tripleCounter", 0)

    xi.mix.jobSpecial.config(mob, {
        delay = 180,
        specials =
        {
            {
                id = xi.jsa.HUNDRED_FISTS,
                hpp = 100,
                cooldown = 120,
            },
        },
    })
end

entity.onMobWeaponSkillPrepare = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill, action)
    local startTriple = mob:getLocalVar("startTriple")
    local tripleCounter = mob:getLocalVar("tripleCounter")
    local pause = mob:getLocalVar("pause")
    local skillId = skill:getID()

    -- Catch-all to ensure variables aren't in a broken state
    if startTriple == 0 and tripleCounter == 0 and pause == 0 then
        mob:setLocalVar("startTriple", 1)
    end

    -- For anything other than slam dunk (607) or shoulder slam (790), we can just carry on
    if not (skillId == 607 or skillId == 790) then
        return 0
    end

    -- Use the abilities 3 times, but not if it's his 2hr
    if startTriple == 1 and (skillId == 607 or skillId == 790) then
        mob:setLocalVar("tripleCounter", 2)
        mob:setLocalVar("startTriple", 0)
        mob:useMobAbility(skillId) -- Queue the same skill up two more times
        mob:useMobAbility(skillId)
    end

    -- If we're in a triple-attack, we need to count down to know when to pause
    if tripleCounter > 0 then
        mob:setLocalVar("tripleCounter", tripleCounter - 1)
        if tripleCounter == 1 then -- if the var is 1, then we have now set it to 0.  Time for a breather.
            mob:setLocalVar("pause", 1)
        end
    end

    return 0
end

entity.onMobFight = function(mob, target)
    -- Take a pause after 3 uses
    if mob:getLocalVar("pause") == 1 then
        -- Ability count reaches zero - take a breath
        mob:setLocalVar("pause", 0)
        mob:setLocalVar("startTriple", 1) -- Allow for another triple attack after cooldown
        mob:SetAutoAttackEnabled(false)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)

        -- Send the message out, but give it a second unutil after the final JA lands
        mob:timer(1500, function (m)
            target:messageSpecial(ID.text.BULLHEADED_BREATH)
        end)

        -- Random timer of 8-12 seconds to return to normal and reset hate on last target
        mob:timer(math.random(8000, 12000), function(m)
            m:SetAutoAttackEnabled(true)
            m:setMobMod(xi.mobMod.NO_MOVE, 0)
            m:resetEnmity(target)
        end)
    end

end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
