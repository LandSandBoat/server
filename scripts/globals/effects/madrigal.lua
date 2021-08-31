-----------------------------------
-- xi.effect.MADRIGAL
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, effect:getPower())
end

return effect_object
