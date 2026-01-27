-----------------------------------
-- xi.effect.DEFENDER
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local jpLevel = target:getJobPointLevel(xi.jp.DEFENDER_EFFECT)
    local jpEffect = jpLevel * 3

    effect:addMod(xi.mod.DEFP, power)
    effect:addMod(xi.mod.RATTP, -25)
    effect:addMod(xi.mod.ATTP, -25)

    -- Job Point Bonuses
    effect:addMod(xi.mod.DEF, jpEffect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
