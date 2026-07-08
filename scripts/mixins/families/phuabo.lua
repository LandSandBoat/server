-- Phuabo family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.phuabo = function(phuaboMob)
    phuaboMob:addListener('SPAWN', 'PHUABO_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(5)
        mob:wait(2000)
    end)

    phuaboMob:addListener('ENGAGE', 'PHUABO_ENGAGE', function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
        mob:setAnimationSub(6)
        mob:wait(2000)
    end)

    phuaboMob:addListener('DISENGAGE', 'PHUABO_DISENGAGE', function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(5)
        mob:wait(2000)
    end)
end

return g_mixins.families.phuabo
