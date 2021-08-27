-----------------------------------
-- xi.effect.DROWN
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:addMod(xi.mod.STR, -getElementalDebuffStatDownFromDOT(effect:getPower()))
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:delMod(xi.mod.STR, -getElementalDebuffStatDownFromDOT(effect:getPower()))
end

return effect_object
