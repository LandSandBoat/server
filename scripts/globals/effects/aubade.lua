-----------------------------------
-- xi.effect.AUBADE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SLEEPRES, effect:getPower())
    target:addMod(xi.mod.LULLABYRES, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SLEEPRES, effect:getPower())
    target:delMod(xi.mod.LULLABYRES, effect:getPower())
end

return effect_object
