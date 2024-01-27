-----------------------------------
-- xi.effect.INNIN
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect) --power=30 initially, subpower=20 for enmity
    target:addMod(xi.mod.EVA, -effect:getPower())
    target:addMod(xi.mod.ENMITY, -effect:getSubPower())

    local jpValue = target:getJobPointLevel(xi.jp.INNIN_EFFECT)
    target:addMod(xi.mod.ACC, jpValue)
end

effectObject.onEffectTick = function(target, effect)
    --tick down the effect and reduce the overall power
    effect:setPower(effect:getPower()-1)
    target:delMod(xi.mod.EVA, -1)
    if effect:getPower() % 2 == 0 then -- enmity- decays from -20 to -10, so half as often as the rest.
        effect:setSubPower(effect:getSubPower()-1)
        target:delMod(xi.mod.ENMITY, -1)
    end
end

effectObject.onEffectLose = function(target, effect)
    --remove the remaining power
    target:delMod(xi.mod.EVA, -effect:getPower())
    target:delMod(xi.mod.ENMITY, -effect:getSubPower())

    local jpValue = target:getJobPointLevel(xi.jp.INNIN_EFFECT)
    target:delMod(xi.mod.ACC, jpValue)
end

return effectObject
