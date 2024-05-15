require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.ruszor = function(ruszorMob)
    ruszorMob:addListener('EFFECT_LOSE', 'STONESKIN', function(mob, effect)
        if effect:getEffectType() == xi.effect.STONESKIN then
            mob:setAnimationSub(0)
        end
    end)
end

return g_mixins.ruszor
