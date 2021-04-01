-----------------------------------
-- xi.effect.ELEMENTAL_RESISTANCE_DOWN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FIRERES, -effect:getPower())
    target:addMod(xi.mod.ICERES, -effect:getPower())
    target:addMod(xi.mod.WINDRES, -effect:getPower())
    target:addMod(xi.mod.EARTHRES, -effect:getPower())
    target:addMod(xi.mod.THUNDERRES, -effect:getPower())
    target:addMod(xi.mod.WATERRES, -effect:getPower())
    target:addMod(xi.mod.LIGHTRES, -effect:getPower())
    target:addMod(xi.mod.DARKRES, -effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FIRERES, -effect:getPower())
    target:delMod(xi.mod.ICERES, -effect:getPower())
    target:delMod(xi.mod.WINDRES, -effect:getPower())
    target:delMod(xi.mod.EARTHRES, -effect:getPower())
    target:delMod(xi.mod.THUNDERRES, -effect:getPower())
    target:delMod(xi.mod.WATERRES, -effect:getPower())
    target:delMod(xi.mod.LIGHTRES, -effect:getPower())
    target:delMod(xi.mod.DARKRES, -effect:getPower())
end

return effect_object
