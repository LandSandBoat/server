-----------------------------------
-- tpz.effect.RASP
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.REGEN_DOWN, effect:getPower())
    target:addMod(tpz.mod.DEX, -getElementalDebuffStatDownFromDOT(effect:getPower()))
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.REGEN_DOWN, effect:getPower())
    target:delMod(tpz.mod.DEX, -getElementalDebuffStatDownFromDOT(effect:getPower()))
end

return effect_object
