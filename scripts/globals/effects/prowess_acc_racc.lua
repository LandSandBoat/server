-----------------------------------
-- xi.effect.PROWESS
-- Enhanced accuracy and ranged accuracy
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
-- This might not be % in retail...If not a % just change ACCP to just ACC
    target:addMod(xi.mod.ACC, effect:getPower())
    target:addMod(xi.mod.RACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, effect:getPower())
    target:delMod(xi.mod.RACC, effect:getPower())
end

return effect_object
