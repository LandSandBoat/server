-----------------------------------
-- tpz.effect.WARDING_CIRCLE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
   target:addMod(tpz.mod.DEMON_KILLER, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
   target:delMod(tpz.mod.DEMON_KILLER, effect:getPower())
end

return effect_object
