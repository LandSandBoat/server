-----------------------------------
-- xi.effect.YONIN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect) -- power = 30 initially
    target:addMod(xi.mod.ACC, -effect:getPower())
    target:addMod(xi.mod.NINJA_TOOL, effect:getPower())
    target:addMod(xi.mod.ENMITY, effect:getPower())

    local yoninMerits = target:getMerit(xi.merit.YONIN_EFFECT)
    if yoninMerits ~= 0 then
        target:addMod(xi.mod.HP, yoninMerits)
    end

    local jpValue = target:getJobPointLevel(xi.jp.YONIN_EFFECT)
    target:addMod(xi.mod.EVA, 2 * jpValue)
end

effectObject.onEffectTick = function(target, effect)
    --tick down the effect and reduce the overall power
    effect:setPower(effect:getPower() - 1)
    target:delMod(xi.mod.ACC, -1)
    target:delMod(xi.mod.NINJA_TOOL, 1)
    target:delMod(xi.mod.ENMITY, 1)
end

effectObject.onEffectLose = function(target, effect)
    --remove the remaining power
    target:delMod(xi.mod.ACC, -effect:getPower())
    target:delMod(xi.mod.NINJA_TOOL, effect:getPower())
    target:delMod(xi.mod.ENMITY, effect:getPower())

    local yoninMerits = target:getMerit(xi.merit.YONIN_EFFECT)
    if yoninMerits ~= 0 then
        target:delMod(xi.mod.HP, yoninMerits)
    end

    local jpValue = target:getJobPointLevel(xi.jp.YONIN_EFFECT)
    target:delMod(xi.mod.EVA, 2 * jpValue)
end

return effectObject
