-----------------------------------
-- xi.effect.AGGRESSOR
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.AGGRESSOR_EFFECT)

    effect:addMod(xi.mod.RACC, effect:getPower() + jpLevel)
    effect:addMod(xi.mod.ACC, 25 + jpLevel)
    effect:addMod(xi.mod.EVA, -25)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
