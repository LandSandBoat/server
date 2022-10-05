-----------------------------------
-- xi.effect.DARK_SEAL
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DARK_MAGIC_CAST, -effect:getPower())
    target:addMod(xi.mod.DARK_MAGIC_DURATION, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DARK_MAGIC_CAST, -effect:getPower())
    target:delMod(xi.mod.DARK_MAGIC_DURATION, effect:getSubPower())
end

return effect_object
