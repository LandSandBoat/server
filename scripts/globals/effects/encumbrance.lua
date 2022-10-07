-----------------------------------
-- xi.effect.ENCUMBERANCE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setEquipBlock(effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setEquipBlock(0)
end

return effectObject
