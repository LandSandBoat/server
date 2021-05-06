-----------------------------------
-- xi.effect.SHINING_RUBY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEFP, 10)
    target:addMod(xi.mod.MDEF, 4)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEFP, 10)
    target:delMod(xi.mod.MDEF, 4)
end

return effect_object
