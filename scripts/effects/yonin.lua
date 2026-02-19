-----------------------------------
-- xi.effect.YONIN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect) -- power = 30 initially
    effect:addMod(xi.mod.ACC, -effect:getPower())
    effect:addMod(xi.mod.NINJA_TOOL, effect:getPower())
    effect:addMod(xi.mod.ENMITY, effect:getPower())
    effect:addMod(xi.mod.YONIN_UTSUSEMI_ENMITY, 1)

    local yoninMerits = target:getMerit(xi.merit.YONIN_EFFECT)
    if yoninMerits ~= 0 then
        effect:addMod(xi.mod.HP, yoninMerits)
    end

    local jpValue = target:getJobPointLevel(xi.jp.YONIN_EFFECT)
    effect:addMod(xi.mod.EVA, 2 * jpValue)
end

effectObject.onEffectTick = function(target, effect)
    -- Tick down the effect and reduce the overall power.
    effect:setPower(effect:getPower() - 1)
    effect:addMod(xi.mod.ACC, 1)
    effect:addMod(xi.mod.NINJA_TOOL, -1)
    effect:addMod(xi.mod.ENMITY, -1)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
