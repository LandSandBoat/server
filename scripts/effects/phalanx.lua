-----------------------------------
-- xi.effect.PHALANX
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.PHALANX, effect:getPower() + target:getMod(xi.mod.PHALANX_RECEIVED))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
