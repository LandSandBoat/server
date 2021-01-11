-----------------------------------
-- tpz.effect.AFTERMATH
-----------------------------------
require("scripts/globals/aftermath")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    tpz.aftermath.onEffectGain(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    tpz.aftermath.onEffectLose(target, effect)
end

return effect_object
