-----------------------------------
-- xi.effect.STR_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.STR) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.STR))
    end

    target:addMod(xi.mod.STR, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- The effect restores 1 STR every 3 ticks. (1 Tick = 3 seconds).
    local downSTREffectSize = effect:getPower()
    if downSTREffectSize > 0 then
        effect:setPower(downSTREffectSize - 1)
        target:delMod(xi.mod.STR, -1)
    else
        target:delStatusEffect(xi.effect.STR_DOWN)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downSTREffectSize = effect:getPower()
    if downSTREffectSize > 0 then
        target:delMod(xi.mod.STR, -downSTREffectSize)
    end
end

return effectObject
