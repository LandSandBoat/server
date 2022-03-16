-----------------------------------
-- xi.effect.BATTUTA
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.job_utils.rune_fencer.onBattutaEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    xi.job_utils.rune_fencer.onBattutaEffectLose(target, effect)
end

return effect_object
