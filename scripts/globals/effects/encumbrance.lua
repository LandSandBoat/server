-----------------------------------
-- tpz.effect.ENCUMBERANCE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setEquipBlock(effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setEquipBlock(0)
end

return effect_object
