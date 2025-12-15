-----------------------------------
-- xi.effect.POTENCY
--
-- Adds Critical Hit Rate
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

return effectObject
