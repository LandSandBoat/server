-----------------------------------
-- xi.effect.AFTERMATH
-----------------------------------
require("scripts/globals/aftermath")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.aftermath.onEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    xi.aftermath.onEffectLose(target, effect)
end

return effect_object
