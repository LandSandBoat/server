-----------------------------------
-- xi.effect.FOCUS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
   local jpLevel = target:getJobPointLevel(xi.jp.FOCUS_EFFECT)
   target:addMod(xi.mod.ACC, effect:getPower() + jpLevel)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
   local jpLevel = target:getJobPointLevel(xi.jp.FOCUS_EFFECT)
   target:delMod(xi.mod.ACC, effect:getPower() + jpLevel)
end

return effect_object
