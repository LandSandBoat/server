-----------------------------------
-- xi.effect.PALISADE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.PALISADE_BLOCK_BONUS, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.PALISADE_BLOCK_BONUS, effect:getPower())
end

return effect_object
