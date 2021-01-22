-----------------------------------
-- tpz.effect.PROWESS
-- Increased HP and MP
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HPP, effect:getPower())
    target:addMod(tpz.mod.MPP, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HPP, effect:getPower())
    target:delMod(tpz.mod.MPP, effect:getPower())
end

return effect_object
