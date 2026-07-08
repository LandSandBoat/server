-----------------------------------
-- xi.effect.INT_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.INT) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.INT))
    end

    target:addMod(xi.mod.INT, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- The effect restores 1 INT every 3 ticks. (1 Tick = 3 seconds).
    local downINTEffectSize = effect:getPower()
    if downINTEffectSize > 0 then
        effect:setPower(downINTEffectSize - 1)
        target:delMod(xi.mod.INT, -1)
    else
        target:delStatusEffect(xi.effect.INT_DOWN)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downINTEffectSize = effect:getPower()
    if downINTEffectSize > 0 then
        target:delMod(xi.mod.INT, -downINTEffectSize)
    end
end

return effectObject
