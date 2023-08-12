-----------------------------------
-- xi.effect.ACCURACY_DOWN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- the effect restore accuracy of 1 every 3 ticks.
    local downACCEffectSize = effect:getPower()
    if downACCEffectSize > 0 then
        effect:setPower(downACCEffectSize - 1)
        target:delMod(xi.mod.ACC, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downACCEffectSize = effect:getPower()
    if downACCEffectSize > 0 then
        target:delMod(xi.mod.ACC, -effect:getPower())
    end
end

return effectObject
