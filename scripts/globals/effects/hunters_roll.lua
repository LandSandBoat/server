-----------------------------------
-- tpz.effect.HUNTERS_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ACC, effect:getPower())
    target:addMod(tpz.mod.RACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ACC, effect:getPower())
    target:delMod(tpz.mod.RACC, effect:getPower())
end

return effect_object
