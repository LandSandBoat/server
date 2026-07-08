-----------------------------------
-- xi.effect.SANGE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DAKEN, 100) -- 100% daken, mod is cleaned up on effect expiry

    local accuracy = target:getMerit(xi.merit.SANGE)
    effect:addMod(xi.mod.RACC, accuracy)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
