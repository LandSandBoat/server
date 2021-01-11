----------------------------------------
-- tpz.effect.FLURRY
----------------------------------------
require("scripts/globals/status")
----------------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SNAP_SHOT, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SNAP_SHOT, effect:getPower())
end

return effect_object
