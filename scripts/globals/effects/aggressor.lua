-----------------------------------
-- xi.effect.AGGRESSOR
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RACC, effect:getPower())
    target:addMod(xi.mod.ACC, 25)
    target:addMod(xi.mod.EVA, -25)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RACC, effect:getPower())
    target:delMod(xi.mod.ACC, 25)
    target:delMod(xi.mod.EVA, -25)
end

return effect_object
