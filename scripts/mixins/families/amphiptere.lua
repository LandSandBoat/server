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
end

return g_mixins.families.amphiptere
