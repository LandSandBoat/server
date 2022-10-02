-----------------------------------
--
-- xi.effect.ONE_FOR_ALL
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

-- intentionally empty, effects of buff handled by using the power of the effect.
effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
