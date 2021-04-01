-----------------------------------
-- xi.effect.PROWESS
-- Increased HP and MP
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPP, effect:getPower())
    target:addMod(xi.mod.MPP, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPP, effect:getPower())
    target:delMod(xi.mod.MPP, effect:getPower())
end

return effect_object
