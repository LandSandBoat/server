-----------------------------------
-- xi.effect.DEX_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.DEX) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.DEX))
    end

    target:addMod(xi.mod.DEX, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- The effect restores 1 DEX every 3 ticks. (1 Tick = 3 seconds).
    local downDEXEffectSize = effect:getPower()
    if downDEXEffectSize > 0 then
        effect:setPower(downDEXEffectSize - 1)
        target:delMod(xi.mod.DEX, -1)
    else
        target:delStatusEffect(xi.effect.DEX_DOWN)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downDEXEffectSize = effect:getPower()
    if downDEXEffectSize > 0 then
        target:delMod(xi.mod.DEX, -downDEXEffectSize)
    end
end

return effectObject
