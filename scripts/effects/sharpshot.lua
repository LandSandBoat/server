-----------------------------------
-- xi.effect.SHARPSHOT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SHARPSHOT_EFFECT)

    target:addMod(xi.mod.RACC, effect:getPower())
    target:addMod(xi.mod.RATT, jpValue * 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SHARPSHOT_EFFECT)

    target:delMod(xi.mod.RACC, effect:getPower())
    target:delMod(xi.mod.RATT, jpValue * 2)
end

return effectObject
