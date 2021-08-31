-----------------------------------
-- xi.effect.ENLIGHTENMENT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, effect:getPower())
    target:addMod(xi.mod.MND, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, effect:getPower())
    target:delMod(xi.mod.MND, effect:getPower())
end

return effect_object
