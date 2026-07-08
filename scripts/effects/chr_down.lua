-----------------------------------
-- xi.effect.CHR_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if (target:getStat(xi.mod.CHR) - effect:getPower()) < 0 then
        effect:setPower(target:getStat(xi.mod.CHR))
    end

    target:addMod(xi.mod.CHR, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
    -- The effect restores 1 CHR every 3 ticks. (1 Tick = 3 seconds).
    local downCHREffectSize = effect:getPower()
    if downCHREffectSize > 0 then
        effect:setPower(downCHREffectSize - 1)
        target:delMod(xi.mod.CHR, -1)
    else
        target:delStatusEffect(xi.effect.CHR_DOWN)
    end
end

effectObject.onEffectLose = function(target, effect)
    local downCHREffectSize = effect:getPower()
    if downCHREffectSize > 0 then
        target:delMod(xi.mod.CHR, -downCHREffectSize)
    end
end

return effectObject
