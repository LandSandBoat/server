-----------------------------------
-- xi.effect.SHINING_RUBY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEFP, 10)
    target:addMod(xi.mod.MDEF, 4)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEFP, 10)
    target:delMod(xi.mod.MDEF, 4)
end

return effectObject
