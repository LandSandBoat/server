-----------------------------------
-- xi.effect.ADDLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FASTCAST, -effect:getPower()) -- Yes we are subtracting in addMod()
    target:addMod(xi.mod.MACC, -effect:getSubPower()) -- This is intentional
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FASTCAST, -effect:getPower())
    target:delMod(xi.mod.MACC, -effect:getSubPower())
end

return effectObject
