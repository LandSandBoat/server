-----------------------------------
-- xi.effect.WEIGHT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MOVE, -effect:getPower())
    target:addMod(xi.mod.EVA, -10)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MOVE, -effect:getPower())
    target:addMod(xi.mod.EVA, 10)
end

return effect_object
