require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.ruszor = function(ruszorMob)
    ruszorMob:addListener('COMBAT_TICK', 'RUSZOR_AURA', function(mob)
        local animationSub = mob:getAnimationSub()
        local hasEffect    = mob:hasStatusEffect(xi.effect.STONESKIN)
        if animationSub == 1 and hasEffect then
            if mob:getMod(xi.mod.ICE_ABSORB) == 0 then
                mob:setMod(xi.mod.WATER_ABSORB, 0)
                mob:setMod(xi.mod.ICE_ABSORB, 100)
            end
        elseif animationSub == 2 and hasEffect then
            if mob:getMod(xi.mod.WATER_ABSORB) == 0 then
                mob:setMod(xi.mod.ICE_ABSORB, 0)
                mob:setMod(xi.mod.WATER_ABSORB, 100)
            end
        elseif animationSub ~= 0 and not hasEffect then
            -- rather than reset animation sub when the effect is lost (which happens if the mob uses 2 moves back to back)
            -- do it on the next combat tick
            mob:setAnimationSub(0)
            mob:setMod(xi.mod.ICE_ABSORB, 0)
            mob:setMod(xi.mod.WATER_ABSORB, 0)
        end
    end)
end

return g_mixins.families.ruszor
