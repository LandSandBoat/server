-----------------------------------
-- xi.effect.ADDLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FASTCAST, -effect:getPower()) -- Yes we are subtracting in addMod()
    target:addMod(xi.mod.MACC, -effect:getSubPower()) -- This is intentional
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FASTCAST, -effect:getPower())
    target:delMod(xi.mod.MACC, -effect:getSubPower())
end

return effect_object
