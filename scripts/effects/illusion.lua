-----------------------------------
-- xi.effect.ILLUSION
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setCostume(effect:getPower())
    effect:addMod(xi.mod.REGEN_DOWN, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setCostume(0)
end

return effectObject
