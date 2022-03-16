-----------------------------------
-- xi.effect.VALIANCE
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.job_utils.rune_fencer.onVallationValianceEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    xi.job_utils.rune_fencer.onVallationValianceEffectLose(target, effect)
end

return effect_object
