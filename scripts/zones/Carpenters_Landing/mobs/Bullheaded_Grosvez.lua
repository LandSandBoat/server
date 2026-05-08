-----------------------------------
-- Area: Carpenters Landing
--   NM: Bullheaded Grosvez
-- Quest: Behind the Smile
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
mixins = { require('scripts/mixins/job_special'), }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(true)

    mob:addListener('EFFECT_LOSE', 'HUNDRED_FISTS_EFFECT_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.HUNDRED_FISTS then
            mobArg:messageText(mobArg, ID.text.CATCH_HIS_BREATH, false)
            mobArg:setAutoAttackEnabled(false)
            mobArg:setLocalVar('takeABreather', GetSystemTime() + 15)

            -- Reset enmity if needed.
            local target = mobArg:getTarget()
            if target then
                mobArg:resetEnmity(target)
            end
        end
    end)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.HUNDRED_FISTS_1 },
            { id = xi.mobSkill.HUNDRED_FISTS_1, cooldown = 390, hpp = math.random(75, 85) },
        },
    })
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('takeABreather') < GetSystemTime() then
        mob:setAutoAttackEnabled(true)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.SLAM_DUNK_1,
        xi.mobSkill.SHOULDER_TACKLE_2
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId = skill:getID()

    if skillId == xi.mobSkill.SLAM_DUNK_1 then
        local slamDunkRepeats = mob:getLocalVar('slamDunkRepeats')

        if slamDunkRepeats < 2 then
            mob:useMobAbility(xi.mobSkill.SLAM_DUNK_1)
            mob:setLocalVar('slamDunkRepeats', slamDunkRepeats + 1)
        else
            mob:setLocalVar('slamDunkRepeats', 0)
            mob:timer(2500, function(mobArg)
                mobArg:messageText(mobArg, ID.text.CATCH_HIS_BREATH, false)
                mobArg:setLocalVar('takeABreather', GetSystemTime() + 15)
                mobArg:setAutoAttackEnabled(false)

                local targetArg = mobArg:getTarget()
                if targetArg then
                    mobArg:resetEnmity(targetArg)
                end
            end)
        end
    end

    if skillId == xi.mobSkill.SHOULDER_TACKLE_1 then
        local shoulderTackleRepeats = mob:getLocalVar('shoulderTackleRepeats')

        if shoulderTackleRepeats < 2 then
            mob:useMobAbility(xi.mobSkill.SHOULDER_TACKLE_1)
            mob:setLocalVar('shoulderTackleRepeats', shoulderTackleRepeats + 1)
        else
            mob:setLocalVar('shoulderTackleRepeats', 0)
            mob:timer(2500, function(mobArg)
                mobArg:messageText(mobArg, ID.text.CATCH_HIS_BREATH, false)
                mobArg:setLocalVar('takeABreather', GetSystemTime() + 15)
                mobArg:setAutoAttackEnabled(false)

                local targetArg = mobArg:getTarget()
                if targetArg then
                    mobArg:resetEnmity(targetArg)
                end
            end)
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:removeListener('HUNDRED_FISTS_EFFECT_LOSE')
end

return entity
