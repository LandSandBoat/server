-----------------------------------
-- xi.effect.POTENCY
--
-- Adds Haste and Critical Hit Rate
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HASTE_MAGIC, effect:getPower())
    target:addMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HASTE_MAGIC, effect:getPower())
    target:delMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

return effectObject
