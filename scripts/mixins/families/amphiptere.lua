-- Amphiptere family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.amphiptere = function(amphiptereMob)
    amphiptereMob:addListener('SPAWN', 'AMPHIPTERE_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(1)
    end)

    amphiptereMob:addListener('ENGAGE', 'AMPHIPTERE_ENGAGE', function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
        mob:setAnimationSub(0)
    end)

    amphiptereMob:addListener('DISENGAGE', 'AMPHIPTERE_DISENGAGE', function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(1)
    end)

    amphiptereMob:addListener('WEAPONSKILL_USE', 'REAVING_WIND_AURA', function(mobArg, target, actionId, tp, action)
        -- Amphipteres gain a temporary aura following the use of reaving wind.
        if actionId == xi.mobSkill.REAVING_WIND then
            mobArg:setAnimationSub(2)
            -- Zirnitra spams a knockback while aura is active
            mobArg:setLocalVar('auraEndTime', GetSystemTime() + 20)
        end
    end)

    amphiptereMob:addListener('WEAPONSKILL_STATE_EXIT', 'SPAM_KNOCKBACK', function(mobArg, actionId)
        if actionId == xi.mobSkill.REAVING_WIND then
            mobArg:useMobAbility(xi.mobSkill.REAVING_WIND_KNOCKBACK)
        elseif actionId == xi.mobSkill.REAVING_WIND_KNOCKBACK then
            if GetSystemTime() >= mobArg:getLocalVar('auraEndTime') then
                mobArg:setLocalVar('auraEndTime', 0)
                mobArg:setAnimationSub(0)
            else
                mobArg:useMobAbility(xi.mobSkill.REAVING_WIND_KNOCKBACK)
            end
        end
    end)
end

return g_mixins.families.amphiptere
