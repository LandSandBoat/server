-----------------------------------
-- tpz.mod.COVER_EFFECT
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setLocalVar("COVER_ABILITY_TARGET", 0)
end

return effect_object
