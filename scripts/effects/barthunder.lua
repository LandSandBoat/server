-----------------------------------
-- xi.effect.BARTHUNDER
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.THUNDER_MEVA, effect:getPower())
    effect:addMod(xi.mod.MDEF, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
