-----------------------------------
-- xi.effect.BOLSTER
-----------------------------------
require("scripts/globals/job_utils/geomancer")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.job_utils.geomancer.bolsterOnEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    xi.job_utils.geomancer.bolsterOnEffectLose(target, effect)
end

return effect_object
