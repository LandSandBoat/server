-----------------------------------
-- tpz.effect.ADDLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FASTCAST, -effect:getPower()) -- Yes we are subtracting in addMod()
    target:addMod(tpz.mod.MACC, -effect:getSubPower()) -- This is intentional
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FASTCAST, -effect:getPower())
    target:delMod(tpz.mod.MACC, -effect:getSubPower())
end

return effect_object
