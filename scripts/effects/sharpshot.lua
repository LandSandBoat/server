-----------------------------------
-- xi.effect.SHARPSHOT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SHARPSHOT_EFFECT)

    effect:addMod(xi.mod.RACC, effect:getPower())
    effect:addMod(xi.mod.RATT, jpValue * 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
