require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.ruszor = function(ruszorMob)
    ruszorMob:addListener('WEAPONSKILL_USE', 'AURA', function(mob, target, actionId, tp, action)
        local frozenMist = 2438
        local hydroWave  = 2439

        -- Ruszor gain a temporary icy aura following the use of Frozen Mist.
        if actionId == frozenMist then
            mob:setAnimationSub(1)
            mob:setMod(xi.mod.WATER_ABSORB, 0)
            mob:setMod(xi.mod.ICE_ABSORB, 100)
            -- Ruszor gain a temporary water aura following the use of Hydro Wave.
        elseif actionId == hydroWave then
            mob:setAnimationSub(2)
            mob:setMod(xi.mod.ICE_ABSORB, 0)
            mob:setMod(xi.mod.WATER_ABSORB, 100)
        end
    end)

    ruszorMob:addListener('EFFECT_LOSE', 'STONESKIN', function(mob, effect)
        if effect:getEffectType() == xi.effect.STONESKIN then
            mob:setAnimationSub(0)
            mob:setMod(xi.mod.ICE_ABSORB, 0)
            mob:setMod(xi.mod.WATER_ABSORB, 0)
        end
    end)
end

return g_mixins.ruszor
