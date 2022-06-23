-----------------------------------
-- xi.effect.POTENCY
--
-- Adds Haste and Critical Hit Rate
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HASTE_MAGIC, effect:getPower())
    target:addMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HASTE_MAGIC, effect:getPower())
    target:delMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

return effect_object
