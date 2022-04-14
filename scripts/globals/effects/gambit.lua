-----------------------------------
-- xi.effect.GAMBIT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
-- intentionall blank, handled in scripts/globals/job_utils/rune_fencer
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
--intentionally blank, effects removed in CPP
end

return effect_object
