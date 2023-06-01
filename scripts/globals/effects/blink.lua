-----------------------------------
-- xi.effect.BLINK
-- No need for addMod since blinks never stack.
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setMod(xi.mod.BLINK, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setMod(xi.mod.BLINK, 0)
end

return effectObject
