-----------------------------------
-- xi.effect.DEFENDER
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local jpLevel = target:getJobPointLevel(xi.jp.DEFENDER_EFFECT)
    local jpEffect = jpLevel * 3

    target:addMod(xi.mod.DEFP, power)
    target:addMod(xi.mod.RATTP, -25)
    target:addMod(xi.mod.ATTP, -25)

    -- Job Point Bonuses
    target:addMod(xi.mod.DEF, jpEffect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    local jpLevel = target:getJobPointLevel(xi.jp.DEFENDER_EFFECT)
    local jpEffect = jpLevel * 3

    target:delMod(xi.mod.DEFP, power)
    target:delMod(xi.mod.ATTP, -25)
    target:delMod(xi.mod.RATTP, -25)

    -- Job Point Bonuses
    target:delMod(xi.mod.DEF, jpEffect)
end

return effectObject
