-- Dragon family variant introduced in ToAU and found various zones.

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.red_dragon = function(redDragonMob)
    -- mob has a regain of 150 per tick while silence effect is on
    redDragonMob:addListener('EFFECT_GAIN', 'RED_DRAGON_EFFECT_GAIN', function(mob, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mob:addMod(xi.mod.REGAIN, 150)
        end
    end)

    redDragonMob:addListener('EFFECT_LOSE', 'RED_DRAGON_EFFECT_LOSE', function(mob, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mob:delMod(xi.mod.REGAIN, 150)
        end
    end)

    -- fire damage will increase mob tp by 500 while water damage will decrease mob tp by 300
    redDragonMob:addListener('TAKE_DAMAGE', 'RED_DRAGON_TAKE_DAMAGE', function(mob, amount, attacker, attackType, damageType)
        if damageType == xi.damageType.FIRE then
            mob:addTP(500)
        elseif damageType == xi.damageType.WATER then
            mob:delTP(300)
        end
    end)
end

return g_mixins.families.red_dragon
