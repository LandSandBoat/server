-----------------------------------
-- tpz.effect.SHININY_RUBY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEFP, 10)
    target:addMod(tpz.mod.MDEF, 4)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEFP, 10)
    target:delMod(tpz.mod.MDEF, 4)
end

return effect_object
