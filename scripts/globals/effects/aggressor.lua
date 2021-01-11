-----------------------------------
-- tpz.effect.AGGRESSOR
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.RACC, effect:getPower())
    target:addMod(tpz.mod.ACC, 25)
    target:addMod(tpz.mod.EVA, -25)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.RACC, effect:getPower())
    target:delMod(tpz.mod.ACC, 25)
    target:delMod(tpz.mod.EVA, -25)
end

return effect_object
