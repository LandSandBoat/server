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
        local reavingWind   = 2431

        -- Amphipteres gain a temporary aura following the use of reaving wind.
        if actionId == reavingWind then
            mobArg:setAnimationSub(2)
            -- Zirnitra spams a knockback while aura is active
            mobArg:setLocalVar('auraEndTime', os.time() + 20)
        end
    end)

    amphiptereMob:addListener('WEAPONSKILL_STATE_EXIT', 'SPAM_KNOCKBACK', function(mobArg, actionId)
        local reavingWind   = 2431
        local reavingWindKb = 2426

        if actionId == reavingWind then
            mobArg:useMobAbility(reavingWindKb)
        elseif actionId == reavingWindKb then
            if os.time() >= mobArg:getLocalVar('auraEndTime') then
                mobArg:setLocalVar('auraEndTime', 0)
                mobArg:setAnimationSub(0)
            else
                mobArg:useMobAbility(reavingWindKb)
            end
        end
    end)
end

return g_mixins.families.amphiptere
